{ remote-builders, ... }:
{
  nixosModules.saronic-builders =
    { ... }:
    {
      imports = [ remote-builders.nixosModules.default ];
      saronic.remote-builders.enable = true;
      
      nix.distributedBuilds = true;
      nix.extraOptions = "builders-use-substitutes = true";
    };
}
