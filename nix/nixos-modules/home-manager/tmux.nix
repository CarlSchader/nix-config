{ ... }:
{
  nixosModules.tmux-home =
    { ... }:
    {
      programs.tmux = {
        enable = true;
        prefix = "C-a";
        mouse = true;
        keyMode = "vi";
      };
      
      extraConfig = ''
        set -g default-terminal "wezterm"
        set -g terminal-overrides 'xterm*:Tc'
      '';
    };
}
