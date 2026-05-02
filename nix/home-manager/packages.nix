{ neovim-config, ... }:
{
  homeModules.packages =
    { pkgs, ... }:
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
        ffmpeg
        watch
        lsof
        direnv
        ncdu
        gh
        tokei
        feh
        zathura
        htop
        stress-ng
        msgpack-tools
        ledger

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
        clang
        cargo
        protobuf

        # nix
        nix-output-monitor
        nix-index
      ];
    };
}
