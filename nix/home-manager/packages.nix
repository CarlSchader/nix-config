{ neovim-config, ... }:
{
  homeModules.packages =
    { pkgs, lib, ... }:
    let
      system = pkgs.stdenv.system;
    in
    {
      home.packages = with pkgs; [
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

        # video/audio
        ffmpeg-full
        mpv
        vlc
        zathura
        feh

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
        gnumake
        cmake

        # ai tools
        opencode

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
        (lib.hiPrio clang)
        gcc
        cargo
        protobuf

        # nix
        nix-output-monitor
        nix-index
      ];
    };
}
