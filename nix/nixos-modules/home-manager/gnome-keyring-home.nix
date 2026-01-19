{ ... }: {
  nixosModules.gnome-keyring-home = 
  { ... }: {
    services.gnome-keyring = {
      enable = true;
      components = [ "secrets" "pkcs11" ];
    };
  };
}
