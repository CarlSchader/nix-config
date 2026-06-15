{...}: {
  homeModules.acs-rdp-host = {
    pkgs,
    lib,
    config,
    ...
  }: let
    secretPath = config.sops.secrets.rdp_password.path;

    # The setup script that talks to GNOME's RDP backend.
    rdp-setup = pkgs.writeShellScript "acs-rdp-setup" ''
      set -uo pipefail

      GRD_DIR="$HOME/.local/share/gnome-remote-desktop/certificates"
      CRT="$GRD_DIR/rdp-tls.crt"
      KEY="$GRD_DIR/rdp-tls.key"

      # 1. Generate a self-signed TLS cert/key if missing
      if [ ! -f "$CRT" ] || [ ! -f "$KEY" ]; then
        ${pkgs.coreutils}/bin/mkdir -p "$GRD_DIR"
        ${pkgs.openssl}/bin/openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 \
          -subj "/C=US/ST=NA/L=NA/O=GnomeRDP/CN=desktop-ts" \
          -out "$CRT" -keyout "$KEY"
      fi

      # 2. Point grdctl at the cert + key
      /usr/bin/grdctl --headless rdp set-tls-cert "$CRT"
      /usr/bin/grdctl --headless rdp set-tls-key  "$KEY"

      # 3. Set credentials from the decrypted sops secret
      RDP_PW="$(${pkgs.coreutils}/bin/cat ${lib.escapeShellArg secretPath})"
      /usr/bin/grdctl --headless rdp set-credentials carl "$RDP_PW"

      # 4. Enable input control + the RDP backend (idempotent; tolerate already-enabled)
      /usr/bin/grdctl --headless rdp disable-view-only || true
      /usr/bin/grdctl --headless rdp enable || true

      # 5. Ensure the headless backend is running
      /usr/bin/systemctl --user enable --now gnome-remote-desktop-headless.service || true
    '';
  in {
    sops.secrets.rdp_password = {
      sopsFile = ./secrets/rdp.yaml;
      key = "rdp_password";
    };

    # Run the RDP provisioning AFTER sops-nix has decrypted the secret.
    systemd.user.services.acs-rdp-host = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
      Unit = {
        Description = "Configure & enable GNOME headless RDP";
        After = ["sops-nix.service"];
        Wants = ["sops-nix.service"];
        # Only meaningful on the non-NixOS Ubuntu host that has grdctl.
        ConditionPathExists = "/usr/bin/grdctl";
      };
      Service = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${rdp-setup}";
      };
      Install.WantedBy = ["default.target"];
    };

    # Apply immediately on `home-manager switch` (after sops-nix has refreshed
    # the secret), and enable linger so the service/RDP survive logout.
    home.activation.rdpHost = lib.hm.dag.entryAfter ["writeBoundary" "sops-nix"] ''
      if [ ! -f /etc/NIXOS ] && [ -x /usr/bin/grdctl ]; then
        # Enable linger (one-time; needs no sudo on this host).
        if [ -x /usr/bin/loginctl ] && \
           [ "$(/usr/bin/loginctl show-user "$USER" -p Linger --value 2>/dev/null)" != "yes" ]; then
          run /usr/bin/loginctl enable-linger "$USER"
        fi

        # Re-provision now if the user systemd manager is up.
        systemdStatus=$(/usr/bin/systemctl --user is-system-running 2>&1 || true)
        if [[ $systemdStatus == 'running' || $systemdStatus == 'degraded' ]]; then
          run /usr/bin/systemctl --user restart acs-rdp-host.service
        else
          echo "User systemd manager not running; acs-rdp-host will apply on next login."
        fi
        unset systemdStatus
      fi
    '';
  };
}
