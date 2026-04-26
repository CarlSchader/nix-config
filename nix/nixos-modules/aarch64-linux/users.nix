{
  self,
  ...
}:
let
  keys = import ../../lib/keys.nix;
  system = "aarch64-linux";
in
{
  nixosModules."${system}-carl-user" =
    { pkgs, ... }:
    {
      users.defaultUserShell = pkgs.zsh;
      programs.zsh.enable = true;
      users.users.carl = {
        isNormalUser = true;
        description = "Carl Schader";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        hashedPassword = "$6$oUx4cxq3vxiY2Czo$RdM1s7eLdnNgFV9F4UAOCFiZrkiIyW6MuIcXveRqYFmK5GrzVmvwwfkGhMNPgKk3wwu.Ybhh.//JJBPIEj/2K0";
        packages = self.common.${system}.user-packages;
        openssh.authorizedKeys.keys = keys.carl;
      };
    };

  nixosModules."${system}-nixbuild-user" =
    { pkgs, ... }:
    {
      users.defaultUserShell = pkgs.zsh;
      programs.zsh.enable = true;
      users.users.nixbuild = {
        isNormalUser = true;
        description = "builder user for nix distributed builds";
        extraGroups = [
          "kvm"
        ];
        openssh.authorizedKeys.keys = keys.nixbuild;
      };
      nix.settings.trustedUsers = [ "nixbuild" ];
    };
}
