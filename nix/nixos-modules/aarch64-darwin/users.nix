{
  self,
  ...
}:
let
  keys = import ../../lib/keys.nix;
  system = "aarch64-darwin";
in
{
  nixosModules."${system}-carl-user" =
    { ... }:
    {
      users.users.carl = {
        name = "carl";
        home = "/Users/carl";
        packages = self.common.${system}.user-packages;
        openssh.authorizedKeys.keys = keys.carl;
      };
    };

  nixosModules."${system}-carlschader-user" =
    { ... }:
    {
      users.users.carlschader = {
        name = "carlschader";
        home = "/Users/carlschader";
        packages = self.common.${system}.user-packages;
        openssh.authorizedKeys.keys = keys.carl;
      };
    };
}
