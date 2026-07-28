{...}: {
  homeModules.librewolf = {...}: {
    programs.librewolf = {
      enable = true;
      profiles.carl = (import ./profiles/carl.nix) // {isDefault = true;};
      profiles.acs = import ./profiles/acs.nix;
    };

    # Set librewolf as default browser
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "librewolf.desktop";
        "x-scheme-handler/http" = "librewolf.desktop";
        "x-scheme-handler/https" = "librewolf.desktop";
        "x-scheme-handler/about" = "librewolf.desktop";
        "x-scheme-handler/unknown" = "librewolf.desktop";
        "application/xhtml+xml" = "librewolf.desktop";
      };
    };

    home.sessionVariables.BROWSER = "librewolf";
  };

  homeModules.librewolf-acs = {...}: {
    programs.librewolf = {
      enable = true;
      profiles.carl = (import ./profiles/carl.nix) // {isDefault = false;};
      profiles.acs = (import ./profiles/acs.nix) // {isDefault = true;};
    };

    # Set librewolf as default browser
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "librewolf.desktop";
        "x-scheme-handler/http" = "librewolf.desktop";
        "x-scheme-handler/https" = "librewolf.desktop";
        "x-scheme-handler/about" = "librewolf.desktop";
        "x-scheme-handler/unknown" = "librewolf.desktop";
        "application/xhtml+xml" = "librewolf.desktop";
      };
    };

    home.sessionVariables.BROWSER = "librewolf";
  };
}
