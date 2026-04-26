{ ... }:
let
  matchBlocks = {
    "*" = {
      controlMaster = "auto";
      controlPath = "~/.ssh/sockets/%r@%h-%p";
      controlPersist = "1h";
    };
    "ml-pc" = {
      hostname = "ml-pc";
      user = "carl";
      forwardAgent = true;
      forwardX11 = true;
    };
    "macbook-pro-m1" = {
      hostname = "macbook-pro-m1";
      user = "carlschader";
      forwardAgent = true;
      forwardX11 = true;
    };
    "linode-headscale" = {
      hostname = "198.58.104.63";
      user = "root";
      forwardAgent = true;
      forwardX11 = true;
    };
    "ampere-a1" = {
      hostname = "129.153.207.106";
      user = "carl";
      forwardAgent = true;
      forwardX11 = true;
    };
    "remarkable" = {
      hostname = "192.168.0.106";
      user = "root";
      forwardAgent = true;
      forwardX11 = true;
    };
    "conifer-pi" = {
      hostname = "conifer-pi";
      user = "carl";
      forwardAgent = true;
      forwardX11 = true;
    };
    "rpi*" = {
      user = "pi";
      forwardAgent = true;
      forwardX11 = true;
    };
  };
in
{
  homeModules.ssh =
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
