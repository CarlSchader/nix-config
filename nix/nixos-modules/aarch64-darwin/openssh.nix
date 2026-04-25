{ ... }:
{
  nixosModules.openssh-darwin =
    { ... }:
    {
      services.openssh = {
        enable = true;
        extraConfig = ''
          X11Forwarding yes
          AllowAgentForwarding yes
          PasswordAuthentication no
          StreamLocalBindUnlink yes
        '';
      };
    };
}
