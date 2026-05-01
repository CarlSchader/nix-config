{ neovim-config, ... }:
{
  homeModules.acs-packages =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        claude-code
      ];
    };
}
