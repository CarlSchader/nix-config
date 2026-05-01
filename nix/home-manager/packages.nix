{ neovim-config, ... }:
{
  homeModules.packages =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        ## user applications
        ledger # cli tool for accounting
        yubikey-manager
        obsidian
        brave

        ## dev tools
        git
        neovim-config.packages."${pkgs.stdenv.system}".default
        nix-output-monitor
        gnumake
        cmake
        tmux
        vim
        iperf3
        ripgrep
        kubectl
        jq
        zstd
        xz
        unzip
        pigz
        ffmpeg
        nmap
        pnpm
        gnumake
        pwgen
        watch
        nix-index
        lsof
        direnv
        ncdu
        netcat
        nload
        jwt-cli
        mdbook
        gh
        tokei
        feh
        zathura
        protobuf
        tree-sitter
        htop
        stress-ng

        # encryption
        sops
        age
        ssh-to-age
        gnupg
        pinentry-tty
        openssh
        opkssh

        # ai tools
        opencode

        # libraries
        boost
        libfido2 # FIDO2 library for hardware security keys

        # databases
        postgresql

        ## compilers and runtimes
        nodejs_24
        python312
        luajitPackages.luarocks-nix
        lua51Packages.lua
        clang
        cargo

        # linters
        ruff
        prettierd
        nixfmt-tree

        # packaging and project management
        uv
      ];
    };
}
