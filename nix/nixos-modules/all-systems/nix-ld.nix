{ ... }:
{
  nixosModules.nix-ld =
    { pkgs, ... }:
    {
      programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
          # Core / System
          stdenv.cc.cc.lib
          zlib
          glib
          libuuid
          udev
          keyutils

          # Graphical / Electron Apps
          nss
          nspr
          atk
          cairo
          pango
          gdk-pixbuf
          gtk3
          libsecret

          # Wayland
          wayland
          wayland-protocols
          libdecor
          xwayland

          # Toolkits that bridge to Wayland
          gtk3
          gtk4
          qt6.qtwayland

          # X11 Windowing
          libX11
          libXcursor
          libXdamage
          libXext
          libXfixes
          libXi
          libXrandr
          libXrender
          libXtst
          libxcb
          libXcomposite
          libSM
          libICE

          # Audio / Video / 3D
          libGL
          alsa-lib
          libpulseaudio
          udev
        ];
      };
    };
}
