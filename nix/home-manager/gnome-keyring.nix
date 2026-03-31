{ ... }:
{
  homeModules.gnome-keyring = { ... }:
  {
    services.gnome-keyring = {
      enable = true;
      components = [ "secrets" "pkcs11" ];
    };
  };
}
