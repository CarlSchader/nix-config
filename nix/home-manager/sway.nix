{ ... }:
{
  homeModules.sway =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      # programs.ghostty.enable = true;
      programs.wezterm.enable = true;

      wayland.windowManager.sway =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
        in
        {
          enable = true;
          wrapperFeatures.gtk = true;
          extraOptions = [ "--unsupported-gpu" ];
          config = {
            modifier = "Mod4";
            # terminal = "ghostty";
            terminal = "wezterm";
            menu = "${pkgs.wofi}/bin/wofi --show drun";
            startup = [
              {
                command = "dbus-update-activation-environment --systemd GNOME_KEYRING_CONTROL=/run/user/$(id -u)/keyring";
              }
            ];
            keybindings = lib.mkOptionDefault {
              "${mod}+ctrl+2" = "resize set width 50 ppt";
              "${mod}+ctrl+3" = "resize set width 33 ppt";
              "${mod}+ctrl+4" = "resize set width 25 ppt";
              "${mod}+ctrl+5" = "resize set width 20 ppt";
            };
          };
        };
    };

  homeModules.sway-non-nixos =
    {
      pkgs,
      config,
      lib,
      nixgl ? null,
      ...
    }:
    let
      nixGLPkg = if nixgl != null then nixgl.packages.${pkgs.system}.nixGLDefault else null;
      multiarch = if pkgs.stdenv.hostPlatform.isx86_64 then "x86_64-linux-gnu"
        else if pkgs.stdenv.hostPlatform.isAarch64 then "aarch64-linux-gnu"
        else pkgs.stdenv.hostPlatform.config;
      nvidiaEglVendor = pkgs.writeText "10_nvidia.json" ''
        {
          "file_format_version" : "1.0.0",
          "ICD" : {
            "library_path" : "/usr/lib/${multiarch}/libEGL_nvidia.so.0"
          }
        }
      '';
      swayPackage =
        if nixGLPkg != null then
          pkgs.symlinkJoin {
            name = "sway-nixgl";
            paths = [ pkgs.sway ];
            postBuild = ''
              chmod u+w $out/bin
              rm $out/bin/sway
              cat > $out/bin/sway << 'SWAYEOF'
              #!/bin/sh
              export PATH="$HOME/.nix-profile/bin:${pkgs.sway}/bin:$PATH"
              if [ -d /proc/driver/nvidia ]; then
                # Source nixGL env so child processes can find Mesa drivers
                eval "$(grep '^export ' ${nixGLPkg}/bin/nixGL)"
                # Point Mesa apps at the non-NVIDIA render node
                for _node in /sys/class/drm/renderD*; do
                  if [ "$(cat "$_node/device/vendor" 2>/dev/null)" != "0x10de" ]; then
                    export DRI_PRIME="$(basename "$(readlink -f "$_node/device")")"
                    break
                  fi
                done
                export WLR_NO_HARDWARE_CURSORS=1
                export __EGL_VENDOR_LIBRARY_FILENAMES="${nvidiaEglVendor}''${__EGL_VENDOR_LIBRARY_FILENAMES:+:$__EGL_VENDOR_LIBRARY_FILENAMES}"
                export GBM_BACKENDS_PATH=/usr/lib/${multiarch}/gbm
                # Build a temp dir with only nvidia libs to avoid glibc conflicts
                NVIDIA_LIBS=$(mktemp -d)
                trap "rm -rf $NVIDIA_LIBS" EXIT
                for lib in /usr/lib/${multiarch}/libnvidia*.so* /usr/lib/${multiarch}/libcuda*.so* /usr/lib/${multiarch}/libEGL_nvidia*.so* /usr/lib/${multiarch}/libGLX_nvidia*.so* /usr/lib/${multiarch}/libGLESv2_nvidia*.so*; do
                  [ -e "$lib" ] && ln -sf "$lib" "$NVIDIA_LIBS/"
                done
                export LD_LIBRARY_PATH="$NVIDIA_LIBS''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
                exec ${pkgs.sway}/bin/sway --unsupported-gpu "$@"
              else
                exec ${nixGLPkg}/bin/nixGL ${pkgs.sway}/bin/sway "$@"
              fi
              SWAYEOF
              chmod +x $out/bin/sway
            '';
          }
        else
          pkgs.sway;
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

      wayland.windowManager.sway =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
        in
        {
          enable = true;
          package = swayPackage;
          checkConfig = false;
          wrapperFeatures.gtk = true;
          extraOptions = [ "--unsupported-gpu" ];
          config = {
            modifier = "Mod4";
            terminal = "wezterm-gl";
            menu = "${pkgs.wofi}/bin/wofi --show drun";
            bars = [
              {
                position = "bottom";
                statusCommand = "${pkgs.i3status}/bin/i3status";
                trayOutput = "*";
              }
            ];
            startup = [
              {
                command = "dbus-update-activation-environment --systemd PATH=$HOME/.nix-profile/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin GNOME_KEYRING_CONTROL=/run/user/$(id -u)/keyring DRI_PRIME LIBGL_DRIVERS_PATH LD_LIBRARY_PATH __EGL_VENDOR_LIBRARY_FILENAMES GBM_BACKENDS_PATH LIBVA_DRIVERS_PATH";
              }
            ];
            keybindings = lib.mkOptionDefault {
              "${mod}+ctrl+2" = "resize set width 50 ppt";
              "${mod}+ctrl+3" = "resize set width 33 ppt";
              "${mod}+ctrl+4" = "resize set width 25 ppt";
              "${mod}+ctrl+5" = "resize set width 20 ppt";
            };
          };
        };
    };
}
