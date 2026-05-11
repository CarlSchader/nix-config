{ ... }:
{
  homeModules.tmux =
    { ... }:
    {
      programs.tmux = {
        enable = true;
        prefix = "C-a";
        mouse = true;
        keyMode = "vi";
        extraConfig = builtins.readFile ./config;
      };
    };
}
