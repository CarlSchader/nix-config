{ ... }:
{
  homeModules.packages =
    { pkgs, ... }:
    {
      # nixpkgs.config.allowUnsupportedSystem = true;
      # nixpkgs.config.allowUnfree = true;
      # nixpkgs.config.allowBroken = true;

      home.packages = with pkgs; [
        ## user applications
        ledger # cli tool for accounting
        yubikey-manager
        obsidian
        brave
        # openscad
        # freecad

        ## dev tools
        git
        jujutsu
        neovim
        gnumake
        cmake
        tmux
        vim
        ripgrep
        fzf
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

        # linters
        ruff
        prettierd
        nixfmt-tree

        # packaging and project management
        uv
      ];
    };
}
