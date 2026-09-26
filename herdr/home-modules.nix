{...}: {
  homeModules.herdr = {lib, ...}: {
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
        ui = {
          agent_panel_sort = "priority";
          # sidebar_width = 32;
          sound = {
            enabled = true;
          };
          toast = {
            delivery = "herdr";
          };
        };
      };
    };
  };
}
