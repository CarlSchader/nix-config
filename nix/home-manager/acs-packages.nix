{
  neovim-config,
  nixgl,
  ...
}: {
  homeModules.acs-packages = {
    pkgs,
    lib,
    ...
  }: let
    system = pkgs.stdenv.system;

    all-systems-packages = with pkgs; [
      claude-code
      nixgl.packages.${pkgs.system}.nixGLDefault

      ## dev tools
      git
      neovim-config.packages."${system}".default
      tmux
      vim
      ripgrep
      kubectl
      jq
      watch
      lsof
      direnv
      gh
      tokei
      ledger
      htop
      stress-ng
      android-tools
      ncdu
      tree
      awscli2
      sshfs

      # image/video/audio
      ffmpeg-full
      mpv

      # networking
      netcat
      nload
      iperf3
      nmap
      jwt-cli

      # compression
      zstd
      xz
      unzip
      pigz
      msgpack-tools

      # security
      sops
      age
      ssh-to-age
      gnupg
      pinentry-tty
      openssh
      opkssh
      yubikey-manager
      pwgen
      # libraries
      boost
      libfido2 # FIDO2 library for hardware security keys

      # databases
      postgresql

      ## language tools
      nodejs_24
      python312
      uv
      luajitPackages.luarocks-nix
      lua51Packages.lua
      cargo
      rustc
      protobuf

      # nix
      nix-output-monitor
      nix-index
    ];

    linux-packages = with pkgs; [
      pavucontrol
      feh
      vlc
      loupe
    ];

    home-packages =
      all-systems-packages ++ (lib.optionals pkgs.stdenv.hostPlatform.isLinux linux-packages);
  in {
    nixpkgs.config.allowUnsupportedSystem = true;
    nixpkgs.config.allowUnfree = true;

    home.packages = home-packages;
  };
}
