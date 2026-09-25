{
  self,
  nix-darwin,
  ...
}: let
  system = "aarch64-darwin";
  darwin-module = import ./darwin.nix;
in {
  darwinConfigurations."macbook-pro-m1" = nix-darwin.lib.darwinSystem {
    modules = [
      darwin-module

      self.nixosModules."${system}-carlschader-user"
      {
        system.primaryUser = "carlschader";
      }

      self.nixosModules.aarch64-darwin-system-packages
      self.nixosModules.parallelism
      self.nixosModules.tailscaled-darwin
      self.nixosModules.openssh-darwin
      self.nixosModules.aarch64-linux-builders
      {
        aarch64-linux-builders = {
          enable = true;
          sshKeyPath = "/var/root/.ssh/nixbuild-key";
        };
      }

      {
        homebrew.enable = true;
        homebrew.casks = [
          "navigator"
        ];
      }
      # self.nixosModules.mullvad
    ];
  };

  darwinConfigurations."macbook-air-m4" = nix-darwin.lib.darwinSystem {
    modules = [
      darwin-module

      self.nixosModules."${system}-carl-user"
      {
        system.primaryUser = "carl";
      }

      self.nixosModules.aarch64-darwin-system-packages
      self.nixosModules.parallelism
      self.nixosModules.tailscaled-darwin
      self.nixosModules.openssh-darwin
      self.nixosModules.aarch64-linux-builders
      {
        aarch64-linux-builders = {
          enable = true;
          sshKeyPath = "/var/root/.ssh/nixbuild-key";
        };
      }
      {
        homebrew.enable = true;
        homebrew.casks = [
          "navigator"
        ];
      }
      # self.nixosModules.mullvad
    ];
  };
}
