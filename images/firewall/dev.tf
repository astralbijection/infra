terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

# Outer network that everyone else will use
resource "libvirt_network" "outer" {
  name      = "edgefw-dev-outer"
  mode      = "nat"
  bridge    = "fwbr-outer"
  addresses = ["192.168.5.0/24"]

  dns {
    enabled = true
    forwarders {
      address = "8.8.8.8"
    }
  }
}

# Inner network for me and my machines only
resource "libvirt_network" "inner" {
  name      = "edgefw-dev-inner"
  mode      = "none"
  bridge    = "fwbr-inner"
  addresses = []
}

resource "libvirt_volume" "boot" {
  name   = "vyos-1.3.qcow2"
  #source = "vyos-1.3.qcow2"
  source = "images/edgefw.qcow2"
}

resource "libvirt_domain" "edgefw" {
  name        = "edgefw.s.astrid.tech"
  description = "EdgeFW analogue"
  memory      = 2000
  vcpu        = 2
  autostart   = false

  network_interface {
    network_name = libvirt_network.outer.name
  }

  network_interface {
    network_name = libvirt_network.inner.name
  }

  disk {
    volume_id = libvirt_volume.boot.id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}

