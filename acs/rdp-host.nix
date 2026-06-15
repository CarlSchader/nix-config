{...}: {
  homeModules.acs-rdp-host = {
    pkgs,
    lib,
    config,
    ...
  }: {
    sops.secrets.rdp_password = {
      sopsFile = ./secrets/rdp.yaml;
      key = "rdp_password";
    };

    # Provision GNOME's *system* Remote Login (headless-at-boot) RDP backend.
    #
    # GNOME 46 serves headless RDP via the system daemon
    # (gnome-remote-desktop.service, running as the `gnome-remote-desktop` user
    # and configured with `grdctl --system` behind polkit). The per-user
    # `--headless` path never binds port 3389 without a logged-in-session
    # handover, so we configure `--system` here instead.
    #
    # This runs at `home-manager switch` time and uses interactive sudo, so you
    # will be prompted for your password when these steps execute. The
    # `--system` config persists in /var/lib/gnome-remote-desktop, so it only
    # needs to run at switch time (not on every login).
    home.activation.rdpHost = lib.hm.dag.entryAfter ["writeBoundary" "sops-nix"] ''
      if [ ! -f /etc/NIXOS ] && [ -x /usr/bin/grdctl ]; then
        CRT="/etc/gnome-remote-desktop/rdp-tls.crt"
        KEY="/etc/gnome-remote-desktop/rdp-tls.key"

        # One-time cleanup of the old per-user --headless attempt (harmless if absent).
        run /usr/bin/grdctl --headless rdp disable || true
        run /usr/bin/systemctl --user disable --now gnome-remote-desktop-headless.service || true
        run /usr/bin/systemctl --user disable --now acs-rdp-host.service || true

        # 1. Generate a self-signed TLS cert/key (readable by the daemon's user) if missing.
        if ! /usr/bin/sudo test -f "$CRT" || ! /usr/bin/sudo test -f "$KEY"; then
          run /usr/bin/sudo install -d -m 0750 -g gnome-remote-desktop /etc/gnome-remote-desktop
          run /usr/bin/sudo ${pkgs.openssl}/bin/openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 \
            -subj "/C=US/ST=NA/L=NA/O=GnomeRDP/CN=desktop-ts" \
            -out "$CRT" -keyout "$KEY"
          run /usr/bin/sudo /usr/bin/chgrp gnome-remote-desktop "$CRT" "$KEY"
          run /usr/bin/sudo /usr/bin/chmod 0644 "$CRT"
          run /usr/bin/sudo /usr/bin/chmod 0640 "$KEY"
        fi

        # 2. Set credentials from the decrypted sops secret (read as user, applied as root).
        RDP_PW="$(${pkgs.coreutils}/bin/cat ${lib.escapeShellArg config.sops.secrets.rdp_password.path})"
        run /usr/bin/sudo /usr/bin/grdctl --system rdp set-credentials carl "$RDP_PW"

        # 3. Point the system backend at the cert + key, enable input + RDP.
        run /usr/bin/sudo /usr/bin/grdctl --system rdp set-tls-cert "$CRT"
        run /usr/bin/sudo /usr/bin/grdctl --system rdp set-tls-key  "$KEY"
        run /usr/bin/sudo /usr/bin/grdctl --system rdp disable-view-only || true
        run /usr/bin/sudo /usr/bin/grdctl --system rdp enable || true

        # 4. Open the firewall (no-op if ufw inactive) and (re)start the system daemon so it binds 3389.
        run /usr/bin/sudo /usr/sbin/ufw allow 3389/tcp || true
        run /usr/bin/sudo /usr/bin/systemctl restart gnome-remote-desktop.service || true
      fi
    '';
  };
}
