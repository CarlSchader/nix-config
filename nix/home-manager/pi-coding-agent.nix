{...}: {
  homeModules.pi-coding-agent = {...}: {
    programs.pi-coding-agent = {
      enable = true;
      settings = {
        packages = [
          "npm:pi-plan"
          "npm:@dreki-gg/pi-ask-mode"
        ];
      };
    };
  };
}
