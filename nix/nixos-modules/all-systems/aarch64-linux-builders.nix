{ ... }:
{
  nixosModules.aarch64-linux-builders =
    { ... }:
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
          sshKey = "/root/.ssh/nixbuild-key"; # This must be manually added to the local machine at the path
        }
      ];
    };
}
