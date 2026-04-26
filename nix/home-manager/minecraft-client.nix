{ ... }:
{
  homeModules.minecraft-client =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        prismlauncher
        # openjdk21
        # openjdk25
        javaPackages.compiler.temurin-bin.jdk-21
      ];
    };
}
