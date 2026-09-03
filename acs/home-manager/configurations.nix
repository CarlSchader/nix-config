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
  homeConfigurations."x86_64-nixos-acs" = home-manager.lib.homeManagerConfiguration {
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

      self.homeModules.ssh
      self.homeModules.librewolf-acs
      self.homeModules.sway
      self.homeModules.tmux
      self.homeModules.wezterm
      self.homeModules.zathura

      self.homeModules.pi-coding-agent

      {
        home.username = "carl";
        home.homeDirectory = "/home/carl";
      }
    ];
  };

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

      self.homeModules.librewolf-acs

      self.homeModules.bluetooth-applet
      self.homeModules.network-manager-applet
      self.homeModules.preamble
      self.homeModules.gpg-agent

      self.homeModules.sway-non-nixos
      self.homeModules.tmux
      self.homeModules.wezterm-non-nixos
      self.homeModules.zathura

      self.homeModules.pi-coding-agent

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

      self.homeModules.librewolf-acs

      self.homeModules.bluetooth-applet
      self.homeModules.network-manager-applet
      self.homeModules.preamble
      self.homeModules.gpg-agent

      self.homeModules.sway-non-nixos
      self.homeModules.tmux
      self.homeModules.wezterm-non-nixos
      self.homeModules.zathura

      self.homeModules.pi-coding-agent
      {
        my.pi-coding-agent.models = {
          providers = {
            rtx4090-tower = {
              api = "openai-completions";
              apiKey = "EMPTY";
              baseUrl = "http://100.64.0.22:8000/v1";
              models = [
                {id = "qwen-27b";}
              ];
            };
          };
        };
      }

      {
        home.username = "carl";
        home.homeDirectory = "/home/carl";
      }

      sops-nix.homeManagerModules.sops
      {
        sops.age.sshKeyPaths = ["/home/carl/.ssh/id_ed25519"];
      }
    ];
  };
}
