{ self, ... }:
{
  nixosModules.aarch64-linux-system-packages =
    { ... }:
    {
      environment.systemPackages = self.common.aarch64-linux.system-packages;
    };
}
