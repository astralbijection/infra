# Different variants of this home-manager config
{
  astral = import ./.;

  astral-cli = {
    imports = [ self.homeModules.astral ];
    astral.vi.enable = true;
  };

  astral-cli-full = {
    imports = [ self.homeModules.astral-cli ];
    astral.cli.extended = true;
    astral.vi.ide = true;
  };

  astral-macos = {
    imports = [ self.homeModules.astral ];

    astral.cli = {
      # enable = true;
      extended = true;
    };
    astral.vi = {
      enable = true;
      ide = true;
    };
    astral.macos.enable = true;
  };

  astral-scientific = {
    imports = [ self.homeModules.astral-cli ];
    astral.cli.conda-hooks.enable = true;
  };

  astral-gui = {
    imports = [ self.homeModules.astral-cli-full ];
    astral.gui.enable = true;
    astral.gui.xmonad.enable = true;
  };

  astral-gui-tablet = {
    imports = [ self.homeModules.astral-gui ];
    astral.gui.xmonad.enable = true;
  };
}
