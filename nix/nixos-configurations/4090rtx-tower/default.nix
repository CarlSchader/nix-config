{
  self,
  nixpkgs,
  vllm-nix,
  ...
}: let
  system = "x86_64-linux";
  pkgs = import nixpkgs {inherit system;};
in {
  nixosConfigurations.rtx4090-tower = nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      ./configuration.nix
      ./hardware-configuration.nix

      self.nixosModules."${system}-carl-user"
      self.nixosModules.x86_64-linux-system-packages
      self.nixosModules.bluetooth
      self.nixosModules.download-buffer
      self.nixosModules.experimental-features
      self.nixosModules.greetd
      self.nixosModules.nix-ld
      self.nixosModules.openssh
      self.nixosModules.parallelism
      self.nixosModules.polkit
      self.nixosModules.steam
      self.nixosModules.swap-file
      self.nixosModules.sway
      self.nixosModules.tailscaled
      self.nixosModules.thunderbolt
      self.nixosModules.yubikey

      # vllm
      vllm-nix.nixosModules.vllm
      {
        services.vllm = {
          enable = true;
          package = vllm-nix.packages.${pkgs.system}.vllmEnv;
          model = {
            hfId = "RedHatAI/Qwen3.8-27B-INT4";
            servedModelName = "Qwen3.8-27B-INT4-FP8Cache";
            maxModelLen = 65536;
          };
          kvCacheDtype = "fp8";
          attentionBackend = "TRITON_ATTN";
          ui = {
            enable = true;
            host = "0.0.0.0";
            webSearch.enable = true;
          };
        };
      }
    ];
  };
}
