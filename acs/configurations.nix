{
  self,
  nixpkgs,
  home-manager,
  nixgl,
  sops-nix,
  ...
}: let
  x86_64-linux-pkgs = import nixpkgs {
    system = "x86_64-linux";
    config = {
      allowUnfree = true;
    };
  };
in {
  homeConfigurations."acs-laptop" = home-manager.lib.homeManagerConfiguration {
    pkgs = x86_64-linux-pkgs;
    extraSpecialArgs = {inherit nixgl;};
    modules = [
      (
        {lib, ...}: {
          targets.genericLinux.enable = true;
          systemd.user.sessionVariables = {
            PATH = "$HOME/.nix-profile/bin:$PATH";
          };
          home.sessionVariables.SHELL = lib.mkForce "$HOME/.nix-profile/bin/zsh";
        }
      )

      self.homeModules.acs-packages
      self.homeModules.gui-apps-non-nixos
      self.homeModules.acs-ssh
      self.homeModules.acs-shell
      {
        programs.shell.enable = true;
      }

      self.homeModules.bluetooth-applet
      self.homeModules.network-manager-applet
      self.homeModules.preamble
      self.homeModules.gpg-agent

      self.homeModules.spotify-player
      self.homeModules.sway-non-nixos
      self.homeModules.tmux
      self.homeModules.wezterm-non-nixos
      self.homeModules.zathura

      self.homeModules.opencode

      {
        home.username = "carl";
        home.homeDirectory = "/home/carl";
      }
    ];
  };

  homeConfigurations."acs-desktop" = home-manager.lib.homeManagerConfiguration {
    pkgs = x86_64-linux-pkgs;
    extraSpecialArgs = {inherit nixgl;};
    modules = [
      (
        {lib, ...}: {
          targets.genericLinux.enable = true;
          systemd.user.sessionVariables = {
            PATH = "$HOME/.nix-profile/bin:$PATH";
          };
          home.sessionVariables.SHELL = lib.mkForce "$HOME/.nix-profile/bin/zsh";
        }
      )

      self.homeModules.acs-packages
      self.homeModules.gui-apps-non-nixos
      self.homeModules.acs-ssh
      self.homeModules.acs-shell
      {
        programs.shell.enable = true;
      }

      self.homeModules.bluetooth-applet
      self.homeModules.network-manager-applet
      self.homeModules.preamble
      self.homeModules.gpg-agent

      self.homeModules.spotify-player
      self.homeModules.sway-non-nixos
      self.homeModules.tmux
      self.homeModules.wezterm-non-nixos
      self.homeModules.zathura

      self.homeModules.opencode

      {
        home.username = "carl";
        home.homeDirectory = "/home/carl";
      }

      sops-nix.homeManagerModules.sops
      {
        sops.age.sshKeyPaths = ["/home/carl/.ssh/id_ed25519"];
      }
      self.homeModules.acs-rdp-host
    ];
  };
}
