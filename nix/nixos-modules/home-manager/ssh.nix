{ ... }:
let
  commonMatchBlocks = {
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

  saronicMatchblocks = commonMatchBlocks // {
    "saronic" = {
      hostname = "carls-system76";
      user = "saronic";
      forwardAgent = true;
      forwardX11 = true;
      localForwards = [ 
        {
          bind.address = "localhost";
          bind.port = 3000;
          host.address = "localhost";
          host.port = 3000;
        }
      ];
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
        matchBlocks = commonMatchBlocks;
      };
      home.file.".ssh/sockets/.keep".text = "";
    };

  nixosModules.ssh-saronic-home =
    { ... }:
    {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        matchBlocks = saronicMatchblocks;
      };
      home.file.".ssh/sockets/.keep".text = "";
    };
}
