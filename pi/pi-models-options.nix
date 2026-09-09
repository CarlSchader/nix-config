{
  vllm-nix,
  sglang-nix,
  ...
}: {
  pi-models-options = {
    default = {
      providers = {
        dgx-spark = {
          api = "openai-completions";
          apiKey = "EMPTY";
          baseUrl = "http://dgx-spark:30000/v1";
          models = sglang-nix.models;
        };
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
        dgx-spark = {
          api = "openai-completions";
          apiKey = "EMPTY";
          baseUrl = "http://100.64.0.24:30000/v1";
          models = sglang-nix.models;
        };
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
        dgx-spark = {
          api = "openai-completions";
          apiKey = "EMPTY";
          baseUrl = "http://dgx-spark:30000/v1";
          models = sglang-nix.models;
        };
        rtx4090-tower = {
          api = "openai-completions";
          apiKey = "EMPTY";
          baseUrl = "http://0.0.0.0:8000/v1";
          models = vllm-nix.models;
        };
      };
    };

    dgx-spark = {
      providers = {
        dgx-spark = {
          api = "openai-completions";
          apiKey = "EMPTY";
          baseUrl = "http://0.0.0.0:30000/v1";
          models = sglang-nix.models;
        };
        rtx4090-tower = {
          api = "openai-completions";
          apiKey = "EMPTY";
          baseUrl = "http://rtx-4090:8000/v1";
          models = vllm-nix.models;
        };
      };
    };
  };
}
