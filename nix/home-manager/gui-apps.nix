{ ... }:
{
  homeModules.gui-apps =
    { pkgs, ... }:
    {
      nixpkgs.config.allowUnfree = true;
      home.packages = with pkgs; [
        obsidian
        brave
        mailspring
      ];
    };
}
