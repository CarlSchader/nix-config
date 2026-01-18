# These are top level nixos modules. Not just homa-manager user modules.
{
  self,
  nixpkgs,
  home-manager,
  neovim-config,
  ...
}:
let
  inherit (nixpkgs) lib;

  common-home-manager-modules = [
    self.nixosModules.home
    self.nixosModules.rust-overlay-home
    self.nixosModules.shell-configs-home
    self.nixosModules.ssh-home
    self.nixosModules.wezterm-home
    neovim-config.nixosModules.home-manager
  ];

  saronic-home-manager-modules = [
    self.nixosModules.saronic-opk-home
    self.nixosModules.saronic-awscli-home
  ];

  sway-home-manager-modules = [
    self.nixosModules.sway-home
  ];

  common-home-modules = lib.mkMerge common-home-manager-modules;
  sway-home-modules = lib.mkMerge (common-home-manager-modules ++ sway-home-manager-modules);

  saronic-home-modules = lib.mkMerge (common-home-manager-modules ++ saronic-home-manager-modules);
  saronic-sway-home-modules = lib.mkMerge (
    common-home-manager-modules ++ saronic-home-manager-modules ++ sway-home-manager-modules
  );
in
{
  nixosModules.common-home-manager-nixos =
    users:
    { lib, ... }:
    {
      imports = [
        self.nixosModules.rust-overlay-module
        home-manager.nixosModules.home-manager
      ];

      config = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users = lib.genAttrs users (_: common-home-modules);
      };
    };

  nixosModules.sway-home-manager-nixos =
    users:
    { lib, ... }:
    {
      imports = [
        self.nixosModules.rust-overlay-module
        self.nixosModules.sway
        self.nixosModules.kanshi
        home-manager.nixosModules.home-manager
      ];

      config = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users = lib.genAttrs users (_: sway-home-modules);
      };
    };

  nixosModules.saronic-home-manager-nixos =
    users:
    { lib, ... }:
    {
      imports = [
        self.nixosModules.rust-overlay-module
        home-manager.nixosModules.home-manager
      ];

      config = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users = lib.genAttrs users (_: saronic-home-modules);
      };
    };

  nixosModules.saronic-sway-home-manager-nixos =
    users:
    { lib, ... }:
    {
      imports = [
        self.nixosModules.rust-overlay-module
        self.nixosModules.sway
        self.nixosModules.kanshi
        home-manager.nixosModules.home-manager
      ];

      config = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users = lib.genAttrs users (_: saronic-sway-home-modules);
      };
    };

  nixosModules.common-home-manager-darwin =
    users:
    { lib, ... }:
    {
      imports = [
        self.nixosModules.rust-overlay-module
        home-manager.darwinModules.home-manager
      ];

      config = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users = lib.genAttrs users (_: common-home-modules);
      };
    };

  nixosModules.saronic-home-manager-darwin =
    users:
    { lib, ... }:
    {
      imports = [
        self.nixosModules.rust-overlay-module
        home-manager.darwinModules.home-manager
      ];

      config = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users = lib.genAttrs users (_: saronic-home-modules);
      };
    };
}
