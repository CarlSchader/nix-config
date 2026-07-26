{
  settings = {
    "browser.bookmarks.showMobileBookmarks" = true;
    "browser.startup.homepage" = "https://nixos.org";
    "browser.newtabpage.pinned" = [
      {
        title = "NixOS";
        url = "https://nixos.org";
      }
    ];

    # enable profiles
    "browser.profiles.enabled" = true;

    # dark mode
    "ui.systemUsesDarkTheme" = 1; # 0 light, 1 dark, 2 system
    "devtools.theme" = "dark";
    "browser.theme.dark-private-windows" = true;

    # for dark mode disable resist finger printing
    # but only for css
    "privacy.resistFingerprinting" = false;
    "privacy.fingerprintingProtection" = true;
    "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme,-JSDateTimeUTC";
    "layout.css.prefers-color-scheme.content-override" = 2; # 0 light, 1 dark, 2 follow ui.systemUsesDarkTheme

    # vertical tabs
    "sidebar.revamp" = true;
    "sidebar.verticalTabs" = true;
    "sidebar.visibility" = "expand-on-hover";
  };

  bookmarks = {
    force = true;
    settings = [
      (import ../bookmarks/nix-sites.nix)
      (import ../bookmarks/ai.nix)
      (import ../bookmarks/proton.nix)
    ];
  };

  containersForce = true;

  extensions = {
    force = true;
  };

  handlers = {
    force = true;
  };

  search = {
    force = true;
  };
}
