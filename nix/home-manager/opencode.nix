{...}: {
  homeModules.opencode = {...}: {
    programs.opencode = {
      enable = true;
      settings = {
        plugin = ["opencode-claude-auth@latest"];
      };
    };
  };
}
