{ self, nixos-generators, nixpkgs, pkgs }:
let
  flakeTime = self.sourceInfo.lastModified;
  vendored-images = import ./images/vendored { inherit pkgs; };
  build-support = import ./build-support { inherit nixos-generators pkgs; };
in vendored-images // {

  update-ci-workflow = pkgs.callPackage ./update-ci-workflow { inherit self; };
  scan-ci-host-keys = pkgs.callPackage ./scan-ci-host-keys { inherit self; };

  ci-import-and-tag-docker = pkgs.callPackage ./ci-import-and-tag-docker { };
  installer-iso = pkgs.callPackage ./images/installer-iso { inherit self; };

  ifd3f-infra-scripts = pkgs.callPackage ./../../scripts { };

  internal-libvirt-images = pkgs.linkFarm "internal-libvirt-images" [{
    name = "centos-8.qcow2";
    path = vendored-images.vendored-centos-8-cloud;
  }];

  win10hotplug = pkgs.callPackage ./win10hotplug { };
}

