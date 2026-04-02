{ ... }:
{
  homeModules.packages = { pkgs, ... }:
  {
    home.packages = with pkgs; [
      ## user applications
      ledger # cli tool for accounting
      yubikey-manager
      obsidian
      brave
      ghostty

      ## dev tools
      git
      gnumake
      cmake
      tmux
      vim
      ripgrep
			fzf
      kubectl
      jq
      zstd
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
      claude-code
      codex
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
