{ ... }:
{
  homeModules.minecraft-client =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        prismlauncher
        openjdk25
      ];
    };
}
