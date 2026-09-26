{...}: {
  homeModules.herdr = {...}: {
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
