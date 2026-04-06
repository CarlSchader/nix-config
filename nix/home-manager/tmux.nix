{ ... }:
{
  homeModules.tmux =
    { ... }:
    {
      programs.tmux = {
        enable = true;
        # prefix = "C-a";
        prefix = "C-b";
        mouse = true;
        keyMode = "vi";
        extraConfig = ''
                  # Use vim keys for pane navigation
                  bind h select-pane -L
                  bind j select-pane -D
                  bind k select-pane -U
                  bind l select-pane -R

                  # Vim-style pane resizing (hold to repeat)
                  bind -r C-h resize-pane -L 5
                  bind -r C-j resize-pane -D 5
                  bind -r C-k resize-pane -U 5
                  bind -r C-l resize-pane -R 5

                  # Reload config with prefix + r
                  bind r source-file ~/.tmux.conf \; display "Config reloaded!"

                  # Split panes using vim keys
                  bind | split-window -h
                  bind - split-window -v

          				# Allow copying to system clipboard with prefix + y
          				set -s set-clipboard on
        '';
      };
    };
}
