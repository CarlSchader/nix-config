{nixpkgs-android-studio-otter, ...}: {
  homeModules.gui-apps = {pkgs, ...}: {
    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
      obsidian
      slack
      spotify
    ];
  };

  # Variant for non-NixOS (generic Linux) hosts. The chrome-sandbox SUID
  # helper cannot be root-owned in the read-only /nix/store, so Electron and
  # Chromium apps abort. Disable the sandbox instead.
  homeModules.gui-apps-non-nixos = {pkgs, ...}: let
    pkgs-android-studio-otter = import nixpkgs-android-studio-otter {
      system = pkgs.stdenv.system;
      config = {
        allowUnfree = true;
        android_sdk.accept_license = true;
      };
    };
  in {
    nixpkgs.config.allowUnfree = true;

    # Electron reads this to skip the SUID chrome-sandbox helper. Covers
    # obsidian, mailspring, slack, foxglove-studio (terminal + launcher).
    home.sessionVariables.ELECTRON_DISABLE_SANDBOX = "1";
    systemd.user.sessionVariables.ELECTRON_DISABLE_SANDBOX = "1";

    home.packages = with pkgs; [
      obsidian
      slack
      spotify
      # pkgs-android-studio-otter.android-studio
    ];
  };
}
