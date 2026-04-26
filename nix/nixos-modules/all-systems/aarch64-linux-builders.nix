{ ... }:
{
  nixosModules.aarch64-linux-builders =
    { ... }:
    {
      nix.distributedBuilds = true;
      nix.buildMachines = [
        {
          hostName = "ampere-a1";
          system = "aarch64-linux";
          maxJobs = 4;
          speedFactor = 8;
          supportedFeatures = [
            "big-parallel"
            "kvm"
            "nixos-test"
            "benchmark"
          ];
          sshUser = "carl";
          sshKey = "/root/.ssh/nixbuild-key"; # This must be manually added to the local machine at the path
        }
      ];
    };
}
