{ ... }:
{
  homeModules.sway =
    {
      pkgs,
      lib,
      nixgl ? null,
      ...
    }:
    let
      nixGLPkg = if nixgl != null then nixgl.packages.${pkgs.system}.nixGLIntel else null;
      swayPackage =
        if nixGLPkg != null
        then
          pkgs.symlinkJoin {
            name = "sway-nixgl";
            paths = [ pkgs.sway ];
            postBuild = ''
              chmod u+w $out/bin
              rm $out/bin/sway
              cat > $out/bin/sway << 'SWAYEOF'
              #!/bin/sh
              export PATH="$HOME/.nix-profile/bin:${pkgs.sway}/bin:$PATH"
              exec ${nixGLPkg}/bin/nixGLIntel ${pkgs.sway}/bin/sway "$@"
              SWAYEOF
              chmod +x $out/bin/sway
            '';
          }
        else pkgs.sway;
    in
    {
      home.packages = with pkgs; [
        grim
        slurp
        wl-clipboard
        mako
        wofi
        wdisplays
        kanshi
      ];

      home.activation.swayWaylandSession = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [ ! -f /etc/NIXOS ]; then
          run /usr/bin/sudo install -Dm644 /dev/stdin /usr/share/wayland-sessions/sway.desktop <<EOF
        [Desktop Entry]
        Name=Sway
        Comment=An i3-compatible Wayland compositor
        Exec=$HOME/.nix-profile/bin/sway
        Type=Application
        EOF
        fi
      '';

      wayland.windowManager.sway = {
        enable = true;
        package = swayPackage;
        wrapperFeatures.gtk = true;
        extraOptions = [ "--unsupported-gpu" ];
        config = {
          modifier = "Mod4";
          terminal = "wezterm-gl";
          menu = "${pkgs.wofi}/bin/wofi --show drun";
          startup = [
            {
              command = "dbus-update-activation-environment --systemd PATH=$HOME/.nix-profile/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin GNOME_KEYRING_CONTROL=/run/user/$(id -u)/keyring";
            }
          ];
        };
      };
    };
}
