{ ... }:
{
  homeModules.ghostty = { pkgs, ... }:
  {
    home.packages = with pkgs; [
      ghostty
    ];

    programs.ghostty = {
      enable = true;
			enableZshIntegration = true;
      settings = ''
      	theme = Synthwave
				cursor-style = block
				cursor-style-blink = false
      '';
    };
  };
}
