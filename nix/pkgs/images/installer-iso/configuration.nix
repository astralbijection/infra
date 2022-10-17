# Stolen from https://github.com/wagdav/homelab/blob/master/installer/iso.nix
# Also from https://hoverbear.org/blog/nix-flake-live-media/

{ config, pkgs, modulesPath, ... }: {
  imports = [
    # https://nixos.wiki/wiki/Creating_a_NixOS_live_CD
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    "${modulesPath}/installer/cd-dvd/channel.nix"
  ];

  users.mutableUsers = false;
  networking.wireless.enable = true;

  astral = {
    users.astrid.enable = true;
    net.sshd.enable = true;
  };
}