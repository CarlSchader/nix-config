{
  self,
  nix-darwin,
  ...
}:
let
  system = "aarch64-darwin";
  darwin-module = import ./darwin.nix;
in
{
  darwinConfigurations."macbook-pro-m1" = nix-darwin.lib.darwinSystem {
    modules = [
      darwin-module

      self.nixosModules."${system}-carlschader-user"

      self.nixosModules.aarch64-darwin-system-packages
      self.nixosModules.parallelism
      self.nixosModules.tailscaled-darwin
      self.nixosModules.openssh-darwin
      self.nixosModules.aarch64-linux-builders
    ];
  };

  darwinConfigurations."macbook-air-m4" = nix-darwin.lib.darwinSystem {
    modules = [
      darwin-module

      self.nixosModules."${system}-carl-user"

      self.nixosModules.aarch64-darwin-system-packages
      self.nixosModules.parallelism
      self.nixosModules.tailscaled-darwin
      self.nixosModules.aarch64-linux-builders
    ];
  };
}
