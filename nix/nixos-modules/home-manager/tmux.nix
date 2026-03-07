{ ... }:
{
  nixosModules.tmux-home =
    { ... }:
    {
      programs.tmux = {
        enable = true;
        prefix = "C-a";
        mouse = true;
        keyMode = "vi";
      };
    };
}
