{ neovim-config, nixgl, ... }:
{
  homeModules.acs-packages =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        claude-code
        nixgl.packages.${pkgs.system}.nixGLDefault
      ];
    };
}
