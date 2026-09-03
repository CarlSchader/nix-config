{...}: {
  homeModules.pi-coding-agent = {...}: {
    programs.pi-coding-agent = {
      enable = true;
      models = {
        providers = {
          rtx4090-tower = {
            api = "openai-completions";
            apiKey = "EMPTY";
            baseUrl = "http://rtx4090-tower:8000/v1";
            models = [
              {id = "qwen-27b";}
            ];
          };
        };
      };
      settings = {
        packages = [
          "npm:pi-plan"
          "npm:@dreki-gg/pi-ask-mode"
          "npm:pi-web-access"
        ];
      };
    };
  };
}
