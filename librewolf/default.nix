{...}: let
  policies = {
    # Install 'New Tab Override' extension
    ExtensionSettings = {
      "newtaboverride@agenedia.com" = {
        install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/new-tab-override/latest.xpi";
        installation_mode = "force_installed";
      };
    };

    # Tie homepage to new tab
    "3rdparty" = {
      "Extensions" = {
        "newtaboverride@agenedia.com" = {
          "type" = "homepage";
        };
      };
    };
  };
in {
  homeModules.librewolf = {
    pkgs,
    lib,
    ...
  }: {
    programs.librewolf = {
      inherit policies;
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
      inherit policies;
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
