{...}: {
  homeModules.librewolf = {
    pkgs,
    lib,
    ...
  }: {
    programs.librewolf = {
      enable = true;
      profiles.carl = (import ./profiles/carl.nix) // {isDefault = true;};
      profiles.acs = (import ./profiles/acs.nix) // {isDefault = false;};
    };

    xdg.mimeApps = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
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

    home.sessionVariables.BROWSER = lib.mkIf pkgs.stdenv.hostPlatform.isLinux "librewolf";
  };

  homeModules.librewolf-acs = {
    pkgs,
    lib,
    ...
  }: {
    programs.librewolf = {
      enable = true;
      profiles.carl = (import ./profiles/carl.nix) // {isDefault = false;};
      profiles.acs = (import ./profiles/acs.nix) // {isDefault = true;};
    };

    xdg.mimeApps = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
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

    home.sessionVariables.BROWSER = lib.mkIf pkgs.stdenv.hostPlatform.isLinux "librewolf";
  };
}
