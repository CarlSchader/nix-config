{ ... }:
{
  homeModules.gui-apps =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        obsidian
        brave
      ];
    };
}
