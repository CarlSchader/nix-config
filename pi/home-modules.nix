{self, ...}: {
  homeModules.pi-coding-agent = {
    pkgs,
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
        default = "dgx-spark";
      };

      defaultModel = lib.mkOption {
        type = lib.types.str;
        description = "Default model";
        default = "qwen3.8-27b"; # see https://github.com/carlschader/vllm-nix
      };
    };

    config = {
      programs.pi-coding-agent = {
        enable = true;
        models = config.my.pi-coding-agent.models;
        settings = {
          defaultProvider = config.my.pi-coding-agent.defaultProvider;
          defaultModel = config.my.pi-coding-agent.defaultModel;
          packages = [
            "npm:pi-mcp-adapter"
            "npm:pi-web-access"
            # "npm:pi-subagents"
            "npm:@tintinweb/pi-subagents"
            "npm:@juicesharp/rpiv-ask-user-question"
            "npm:@juicesharp/rpiv-todo"
            # "npm:context-mode"
            # "npm:pi-lens"
            # "npm:@plannotator/pi-extension"
            "npm:@dreki-gg/pi-ask-mode"
            "npm:@gotgenes/pi-permission-system"
          ];
        };
      };

      home.file.".pi/web-search.json".text = builtins.toJSON {
        workflow = "auto-summary"; # don't open browser curator; auto-generate summary
      };

      home.file.".pi/agent/extensions/pi-permission-system/config.json".source = (pkgs.formats.json {}).generate "pi-permission-config.json" {
        permission = {
          "*" = "allow";
          # external_directory = "ask";
          bash = {
            "*" = "allow";
            "git commit *" = "ask";
            "git push *" = "ask";
          };
        };
      };
    };
  };
}
