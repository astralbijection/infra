# The desk that is used by Good Friends.
{ self, ... }:
{ config, lib, pkgs, ... }: {
  imports = with self.nixosModules; [ ./hardware-configuration.nix ];

  astral = {
    roles.server.enable = true;
    users.alia.enable = true;
    virt = {
      docker.enable = true;
      libvirt.enable = true;
      lxc.enable = true;
    };
    net.zerotier.public = true;
  };

  time.timeZone = "US/Pacific";

  # Explicitly don't reboot on kernel upgrade. This server takes forever to reboot, plus 
  # it's a jet engine when it boots and it will probably wake me up at 4:00 AM
  system.autoUpgrade.allowReboot = false;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.astrid = {
      imports = with self.homeModules; [ astrid_cli_full astrid_vi_full ];
    };
  };

  networking = {
    hostId = "6d1020a1"; # Required for ZFS
    useDHCP = false;

    bridges."br0".interfaces = [ "eno1" ];
    firewall.allowedTCPPorts = [ 25565 ];
    interfaces = {
      eno1.useDHCP = true;
      eno2.useDHCP = true;
      eno3.useDHCP = true;
      eno4.useDHCP = true;
      br0.useDHCP = true;
    };
  };

  # Use the GRUB 2 boot loader.
  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      copyKernels = true;
      # HP G8 only supports BIOS, not UEFI
      device = "/dev/disk/by-id/wwn-0x600508b1001c5e757c79ba52c727a91f";
    };

    initrd = {
      availableKernelModules =
        [ "ehci_pci" "ata_piix" "uhci_hcd" "hpsa" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };

    extraModulePackages = [ ];
  };
}
