{...}: {
  homeModules.pi-coding-agent = {
    config,
    lib,
    ...
  }: {
    options.my.pi-coding-agent.models = lib.mkOption {
      type = lib.types.attrs;
      description = "Model/provider configuration for pi-coding-agent.";
      default = {
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
    };

    config.programs.pi-coding-agent = {
      enable = true;
      models = config.my.pi-coding-agent.models;
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
