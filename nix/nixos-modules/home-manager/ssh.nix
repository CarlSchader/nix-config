{ ... }:
{
  nixosModules.ssh-home =
    { ... }:
    {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        matchBlocks = {
          "*" = {
            controlMaster = "auto";
            controlPath = "~/.ssh/sockets/%r@%h-%p";
            controlPersist = "1h";
          };
          "carl" = {
            hostname = "carlschader.com";
            user = "carl";
            forwardAgent = true;
            forwardX11 = true;
          };
        };
      };

      home.file.".ssh/sockets/.keep".text = "";
    };
}
