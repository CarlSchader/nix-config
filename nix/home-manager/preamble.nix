{...}: {
  homeModules.preamble = {...}: {
    home.stateVersion = "26.11";
    programs.home-manager.enable = true;

    # force update mimeapps
    xdg.configFile."mimeapps.list".force = true;
  };
}
