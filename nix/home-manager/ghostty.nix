{ ... }:
{
  homeModules.ghostty = { pkgs, ... }:
  {
    programs.ghostty = {
      enable = true;
			enableZshIntegration = true;
      settings = {
        theme = "Synthwave";
				cursor-style = "block";
				cursor-style-blink = false;
      };
    };
  };
}
