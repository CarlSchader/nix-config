{
  self,
  ...
}:
let
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
      };
    };

  nixosModules."${system}-carlschader-user" =
    { ... }:
    {
      users.users.carlschader = {
        name = "carlschader";
        home = "/Users/carlschader";
        packages = self.common.${system}.user-packages;
      };
    };
}
