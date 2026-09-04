{vllm-nix, ...}: {
  pi-models-options = {
    default = {
      providers = {
        rtx4090-tower = {
          api = "openai-completions";
          apiKey = "EMPTY";
          baseUrl = "http://rtx4090-tower:8000/v1";
          models = vllm-nix.models;
        };
      };
    };
    acs = {
      providers = {
        rtx4090-tower = {
          api = "openai-completions";
          apiKey = "EMPTY";
          baseUrl = "http://100.64.0.22:8000/v1";
          models = vllm-nix.models;
        };
      };
    };
    rtx4090-tower = {
      providers = {
        rtx4090-tower = {
          api = "openai-completions";
          apiKey = "EMPTY";
          baseUrl = "http://0.0.0.0:8000/v1";
          models = vllm-nix.models;
        };
      };
    };
  };
}
