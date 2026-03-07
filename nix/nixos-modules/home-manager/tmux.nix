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
        extraConfig = ''
          # Use vim keys for pane navigation
          bind h select-pane -L
          bind j select-pane -D
          bind k select-pane -U
          bind l select-pane -R

          # Split panes using vim keys
          bind | split-window -h
          bind - split-window -v
        '';
      };
    };
}
