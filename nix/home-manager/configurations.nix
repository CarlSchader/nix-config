{
  self,
  nixpkgs,
  home-manager,
  neovim-config,
  ...
}:
let
  motd-strings = import ../lib/motd.nix;
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
in
{
  homeConfigurations."x86_64-linux-carl" = home-manager.lib.homeManagerConfiguration {
    pkgs = x86_64-linux-pkgs;
    modules = [
      self.homeModules.preamble
      self.homeModules.packages
      # self.homeModules.ghostty
      self.homeModules.gnome-keyring
      self.homeModules.shell
      self.homeModules.spotify-player
      self.homeModules.ssh
      self.homeModules.sway
      self.homeModules.tmux
      self.homeModules.wezterm
      neovim-config.homeModules.default
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
      self.homeModules.permissions
      self.homeModules.shell
      {
        programs.shell.enable = true;
        programs.shell.motd = motd-strings.macbook-air;
      }
      self.homeModules.spotify-player
      self.homeModules.ssh
      self.homeModules.tmux
      self.homeModules.wezterm
      neovim-config.homeModules.default
      {
        home.username = "carl";
        home.homeDirectory = "/Users/carl";
      }
    ];
  };
}
