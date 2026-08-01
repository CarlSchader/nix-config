{...}: {
  homeModules.preamble = {
    pkgs,
    lib,
    ...
  }: let
    linuxOptions = {
      # force update mimeapps
      xdg.configFile."mimeapps.list".force = true;
    };
    darwinOptions = {
    };
  in
    lib.mkMerge [
      {
        home.stateVersion = "26.11";
        programs.home-manager.enable = true;
      }
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux linuxOptions)
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin darwinOptions)
    ];
}
