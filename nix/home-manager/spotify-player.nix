{ ... }:
{
  homeModules.spotify-player = {
    programs.spotify-player = {
      enable = true;
      settings = {
        enable_audio_visualization = true;
      };
    };
  };
}
