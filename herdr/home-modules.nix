{...}: {
  homeModules.herdr = {lib, pkgs, ...}: {
    # Declarative herdr machine catalog (Nix-owned; edits via `herdr machine`
    # will be overwritten on the next home-manager switch).
    # Installed as a real 0600 file (not a store symlink) so herdr can still
    # read/rewrite it with its private-file semantics.
    home.activation.herdrEndpoints = lib.hm.dag.entryAfter ["writeBoundaryFile"] ''
      run mkdir -p "$HOME/.local/state/herdr/client"
      run install -m 0600 ${./endpoints.json} "$HOME/.local/state/herdr/client/endpoints.json"
    '';

    programs.herdr = {
      enable = true;
      settings = {
        onboarding = false;
        theme = {
          auto_switch = true;
          dark_name = "vesper";
          light_name = "solarized-light";
          name = "vesper";
        };
        # On NixOS the `herdr` nixosModule runs `herdr server` as a system
        # service at boot; make it listen on all interfaces there.
        server = lib.mkIf pkgs.stdenv.isLinux {
          listen_address = "0.0.0.0";
        };
        ui = {
          agent_panel_sort = "priority";
          # sidebar_width = 32;
          sound = {
            enabled = true;
          };
          toast = {
            # "system" -> OS notification service (swaync on the sway
            # machines, macOS notifications on darwin), instead of an
            # in-app toast. Sound still plays via ui.sound (client-side).
            delivery = "system";
          };
        };
        keys = {
          # Sidebar (navigate mode): vim up/down instead of arrow keys
          # (navigate_pane_* already default to h/j/k/l).
          navigate_workspace_up = "k";
          navigate_workspace_down = "j";
          # Pane movement already defaults to prefix+h/j/k/l; add
          # prefix-free ctrl+alt chords (the one modifier family that
          # terminals and desktops leave free).
          focus_pane_left = [ "prefix+h" "ctrl+alt+h" ];
          focus_pane_down = [ "prefix+j" "ctrl+alt+j" ];
          focus_pane_up = [ "prefix+k" "ctrl+alt+k" ];
          focus_pane_right = [ "prefix+l" "ctrl+alt+l" ];
          # tmux-style copy/scroll mode: prefix+[ (vim keys inside).
          # No direct chord: ctrl+alt+[ is the previous_tab chord.
          copy_mode = "prefix+[";
          next_tab = [ "prefix+n" "ctrl+alt+]" ];
          previous_tab = [ "prefix+p" "ctrl+alt+[" ];
        };
      };
    };
  };
}
