{...}: {
  nixosModules.aarch64-linux-builders = {
    pkgs,
    lib,
    config,
    ...
  }: let
    cfg = config.aarch64-linux-builders;
    isDarwin = pkgs.stdenv.isDarwin;
    nixDarwinManagesNix = config.nix.enable or true;
    useEtcMachines = isDarwin && !nixDarwinManagesNix;
  in {
    options.aarch64-linux-builders = {
      enable = lib.mkEnableOption "aarch64-linux-builders";
      sshKeyPath = lib.mkOption {
        type = lib.types.str;
        description = "SSH key needed to hit the builder.";
      };
    };

    config = lib.mkIf cfg.enable (
      lib.mkMerge [
        {
          nix.distributedBuilds = true;
          nix.buildMachines = [
            {
              hostName = "129.153.207.106";
              system = "aarch64-linux";
              protocol = "ssh-ng"; # nixbuild authorized_keys forces `nix-daemon --stdio`, which speaks the modern daemon protocol
              maxJobs = 4;
              speedFactor = 8;
              supportedFeatures = [
                "big-parallel"
                "kvm"
                "nixos-test"
                "benchmark"
              ];
              sshUser = "nixbuild";
              sshKey = cfg.sshKeyPath; # This must be on the local machine at the path
            }
          ];
        }
        # If on nix Darwin and using determinate systems installation we need to set /etc/nix/machines
        (lib.mkIf useEtcMachines {
          environment.etc."nix/machines".text = ''
            ssh-ng://nixbuild@129.153.207.106 aarch64-linux ${cfg.sshKeyPath} 4 8 big-parallel,kvm,nixos-test,benchmark -
          '';
        })
      ]
    );
  };
}
