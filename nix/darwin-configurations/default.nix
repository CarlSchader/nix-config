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
  darwinConfigurations."Carls-MacBook-Pro-2" = nix-darwin.lib.darwinSystem {
    modules = [
      darwin-module

      self.nixosModules."${system}-carlschader-user"
      (self.nixosModules.common-home-manager-darwin [ "carlschader" ])

      self.nixosModules.aarch64-darwin-system-packages
      self.nixosModules.carls-macbook-motd
      self.nixosModules.parallelism

    ];
  };

  darwinConfigurations."Carls-MacBook-Air-2" = nix-darwin.lib.darwinSystem {
    modules = [
      darwin-module

      self.nixosModules."${system}-carl-user"
      (self.nixosModules.common-home-manager-darwin [ "carl" ])

      self.nixosModules.aarch64-darwin-system-packages
      self.nixosModules.carls-macbook-motd
      self.nixosModules.parallelism
    ];
  };
}
