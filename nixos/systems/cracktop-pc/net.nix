{
  networking = {
    hostName = "cracktop-pc";
    domain = "id.astrid.tech";

    hostId = "49e32584";
    networkmanager.enable = true;
    useDHCP = false;

    bridges."br0".interfaces = [
      "enp3s0"
    ];

    interfaces = {
      enp3s0.useDHCP = true;
      wlp2s0.useDHCP = true;
      br0.useDHCP = true;
    };
  };
}