let
  homepage = "https://gemini.google.com/app";
in {
  settings = {
    "browser.bookmarks.showMobileBookmarks" = true;

    # 1 = Blank page, 2 = Previous session, 3 = Home page, 4 = Custom URL
    "browser.startup.page" = 3;
    "browser.startup.homepage" = homepage;

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

    # remember passwords
    "signon.rememberSignons" = true;

    # autofill passwords
    "signon.autofillForms" = true;

    # Do not clear website sessions/cookies on shutdown
    "privacy.sanitize.sanitizeOnShutdown" = false;
    "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;

    # Older/compat pref names
    "privacy.clearOnShutdown.cookies" = false;
    "privacy.clearOnShutdown.offlineApps" = false;

    # LibreWolf disables this by default
    "signon.formlessCapture.enabled" = true;
  };

  bookmarks = {
    force = true;
    settings = [
      (import ../bookmarks/nix-sites.nix)
      (import ../bookmarks/finance.nix)
      (import ../bookmarks/ai.nix)
      (import ../bookmarks/errands.nix)
      (import ../bookmarks/cloud.nix)
      (import ../bookmarks/code.nix)
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
