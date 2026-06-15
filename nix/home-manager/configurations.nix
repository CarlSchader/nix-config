{
  self,
  nixpkgs,
  home-manager,
  nixgl,
  ...
}: let
  x86_64-linux-pkgs = import nixpkgs {
    system = "x86_64-linux";
    config = {
      allowUnfree = true;
    };
  };
  aarch64-darwin-pkgs = import nixpkgs {
    system = "aarch64-darwin";
    config = {
      allowUnfree = true;
    };
  };
  aarch64-linux-pkgs = import nixpkgs {
    system = "aarch64-linux";
    config = {
      allowUnfree = true;
    };
  };
in {
  homeConfigurations."x86_64-linux-carl" = home-manager.lib.homeManagerConfiguration {
    pkgs = x86_64-linux-pkgs;
    modules = [
      self.homeModules.preamble
      self.homeModules.packages
      self.homeModules.bluetooth-applet
      self.homeModules.network-manager-applet
      self.homeModules.gpg-agent
      self.homeModules.gui-apps
      self.homeModules.gnome-keyring
      self.homeModules.shell
      {
        programs.shell.enable = true;
      }

      self.homeModules.spotify-player
      self.homeModules.ssh
      self.homeModules.sway
      self.homeModules.tmux
      self.homeModules.wezterm
      self.homeModules.zathura

      self.homeModules.opencode

      {
        home.username = "carl";
        home.homeDirectory = "/home/carl";
      }
    ];
  };

  homeConfigurations."aarch64-linux-carl" = home-manager.lib.homeManagerConfiguration {
    pkgs = aarch64-linux-pkgs;
    modules = [
      self.homeModules.preamble
      self.homeModules.packages
      self.homeModules.gpg-agent
      self.homeModules.shell
      {
        programs.shell.enable = true;
      }
      self.homeModules.ssh
      self.homeModules.tmux
      {
        home.username = "carl";
        home.homeDirectory = "/home/carl";
      }
    ];
  };

  homeConfigurations."aarch64-darwin-carl" = home-manager.lib.homeManagerConfiguration {
    pkgs = aarch64-darwin-pkgs;
    modules = [
      self.homeModules.preamble
      self.homeModules.packages
      self.homeModules.aerospace
      self.homeModules.gpg-agent
      self.homeModules.gui-apps
      self.homeModules.darwin-permissions
      self.homeModules.shell
      {
        programs.shell.enable = true;
      }
      self.homeModules.spotify-player
      self.homeModules.ssh
      self.homeModules.tmux
      self.homeModules.wezterm

      self.homeModules.opencode

      {
        home.username = "carl";
        home.homeDirectory = "/Users/carl";
      }
    ];
  };

  homeConfigurations."aarch64-darwin-carlschader" = home-manager.lib.homeManagerConfiguration {
    pkgs = aarch64-darwin-pkgs;
    modules = [
      self.homeModules.preamble
      self.homeModules.packages
      self.homeModules.aerospace
      self.homeModules.gpg-agent
      self.homeModules.gui-apps
      self.homeModules.darwin-permissions
      self.homeModules.shell
      {
        programs.shell.enable = true;
      }
      self.homeModules.spotify-player
      self.homeModules.ssh
      self.homeModules.tmux
      self.homeModules.wezterm

      self.homeModules.opencode

      {
        home.username = "carlschader";
        home.homeDirectory = "/Users/carlschader";
      }
    ];
  };
}
