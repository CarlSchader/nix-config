{ ... }:
let
  matchBlocks = {
    "*" = {
      controlMaster = "auto";
      controlPath = "~/.ssh/sockets/%r@%h-%p";
      controlPersist = "1h";
    };
    "carl" = {
      hostname = "ml-pc";
      user = "carl";
      forwardAgent = true;
      forwardX11 = true;
    };
    "linode-headscale" = {
      hostname = "198.58.104.63";
      user = "root";
      forwardAgent = true;
      forwardX11 = true;
    };
    "remarkable" = {
      hostname = "192.168.0.106";
      user = "root";
      forwardAgent = true;
      forwardX11 = true;
    };
  };
in
{
  nixosModules.ssh-home =
    { ... }:
    {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        inherit matchBlocks;
      };
      home.file.".ssh/sockets/.keep".text = "";
    };
}
