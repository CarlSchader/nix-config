{ ... }:
{
  homeModules.darwin-permissions =
    { lib, ... }:
    {
      home.activation = {
        checkAppManagementPermission = lib.mkForce "";
      };
    };
}
