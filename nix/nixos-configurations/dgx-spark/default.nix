  { self, nixpkgs, dgx-spark, ... }:
let
  system = "aarch64-linux";
in
    {
      nixosConfigurations.dgx-spark = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          dgx-spark.nixosModules.dgx-spark

	  self.nixosModules."${system}-carl-user"
 	  self.nixosModules.aarch64-linux-system-packages
	  self.nixosModules.download-buffer
	  self.nixosModules.experimental-features
	  self.nixosModules.greetd
	  self.nixosModules.nix-ld
	  self.nixosModules.openssh
	  self.nixosModules.parallelism
	  self.nixosModules.polkit
	  self.nixosModules.sway
	  self.nixosModules.tailscaled
	  self.nixosModules.thunderbolt
	  self.nixosModules.yubikey
        ];
      };
    }
