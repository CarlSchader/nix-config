{ ... }:
{
  homeModules.gpg-agent =
    { pkgs, lib, ... }:
    {
      services.gpg-agent = {
        enable = true;
        pinentry.package = pkgs.pinentry-tty;
      };

      # 1500 is the standard for after everythin in shell init. This ensures it's very late.
      programs.zsh.initContent = lib.mkOrder 1600 ''
        export GPG_TTY=$(tty)
        gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
      '';
    };
}
