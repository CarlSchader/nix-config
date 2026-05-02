{ ... }:
{
  homeModules.wezterm =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        wezterm
      ];

      programs.wezterm = {
        enable = true;
        extraConfig = builtins.readFile ./config.lua;
      };
    };

  homeModules.wezterm-non-nixos =
    {
      pkgs,
      lib,
      nixgl ? null,
      ...
    }:
    let
      nixGLPkg = if nixgl != null then nixgl.packages.${pkgs.system}.nixGLIntel else null;
      weztermGL =
        if nixGLPkg != null then
          pkgs.writeShellScriptBin "wezterm-gl" ''
            exec ${nixGLPkg}/bin/nixGLIntel ${pkgs.wezterm}/bin/wezterm "$@"
          ''
        else
          pkgs.writeShellScriptBin "wezterm-gl" ''
            exec ${pkgs.wezterm}/bin/wezterm "$@"
          '';
      desktopExec =
        if nixGLPkg != null then
          "${nixGLPkg}/bin/nixGLIntel ${pkgs.wezterm}/bin/wezterm start --cwd ."
        else
          "${pkgs.wezterm}/bin/wezterm start --cwd .";
    in
    {
      home.packages = with pkgs; [
        wezterm
        weztermGL
      ];

      programs.wezterm = {
        enable = true;
        extraConfig = builtins.readFile ./config.lua;
        enableZshIntegration = true;
      };

      home.file.".local/share/applications/wezterm.desktop".text = ''
        [Desktop Entry]
        Name=WezTerm
        Comment=Wez's Terminal Emulator
        Keywords=shell;prompt;command;commandline;cmd;
        Icon=org.wezfurlong.wezterm
        StartupWMClass=org.wezfurlong.wezterm
        Exec=${desktopExec}
        Type=Application
        Categories=System;TerminalEmulator;Utility;
        Terminal=false
      '';
    };
}
