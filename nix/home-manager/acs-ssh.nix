{ ... }:
let
  matchBlocks = {
    "acs-desktop" = {
      hostname = "10.0.29.145";
      user = "carl";
      forwardAgent = true;
      forwardX11 = true;
    };
  };
in
{
  homeModules.acs-ssh =
    { ... }:
    {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        inherit matchBlocks;
      };
    };
}
