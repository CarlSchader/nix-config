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

          # Vim-style pane resizing (hold to repeat)
          bind -r H resize-pane -L 5
          bind -r J resize-pane -D 5
          bind -r K resize-pane -U 5
          bind -r L resize-pane -R 5

          # Split panes using vim keys
          bind | split-window -h
          bind - split-window -v
        '';
      };
    };
}
