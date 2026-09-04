{self, ...}: {
  homeModules.pi-coding-agent = {
    config,
    lib,
    ...
  }: {
    options.my.pi-coding-agent = {
      models = lib.mkOption {
        type = lib.types.attrs;
        description = "Model/provider configuration for pi-coding-agent.";
        default = self.pi-models-options.default;
      };

      defaultProvider = lib.mkOption {
        type = lib.types.str;
        description = "Default model provider";
        default = "rtx4090-tower";
      };

      defaultModel = lib.mkOption {
        type = lib.types.str;
        description = "Default model";
        default = "Qwen3.8-27B-INT4-FP8Cache"; # see https://github.com/carlschader/vllm-nix
      };
    };

    config.programs.pi-coding-agent = {
      enable = true;
      models = config.my.pi-coding-agent.models;
      settings = {
        defaultProvider = config.my.pi-coding-agent.defaultProvider;
        defaultModel = config.my.pi-coding-agent.defaultModel;
        packages = [
          "npm:pi-plan"
          "npm:@dreki-gg/pi-ask-mode"
          "npm:pi-web-access"
        ];
      };
    };
  };
}
