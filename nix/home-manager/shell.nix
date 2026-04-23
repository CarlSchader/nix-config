{ ... }:
let
  sessionVariables = {
    EDITOR = "nvim";
    SOPS_EDITOR = "vim";
  };

  initContent = ''
            			export ANTHROPIC_API_KEY=$(cat ~/.secrets/anthropic-api-key)
            			export OPENAI_API_KEY=$(cat ~/.secrets/openai-api-key)
            			export GEMINI_API_KEY=$(cat ~/.secrets/gemini-api-key)
            			export GPG_TTY=$(tty)

            			eval "$(direnv hook zsh)"

            			# only run this code if we're not in an ssh session 
            			if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ] && [ -z "$SSH_CONNECTION" ]; then
            				source <(ssh-agent)
            				ssh-add
            				ssh-add ~/.ssh/id_ed25519_sk_rk
            			fi

            			# If this is an SSH session, symlink the current agent socket to a static path
            			if [ -n "$SSH_AUTH_SOCK" ] && [ "$SSH_AUTH_SOCK" != "$HOME/.ssh/ssh_auth_sock" ]; then
            					ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh_auth_sock"
            			fi
            			export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"

        					gpg-ssh() {
    								local remote="$1"; shift
    								local local_sock="$(gpgconf --list-dir agent-extra-socket)"
    								local remote_sock="$(ssh "$remote" gpgconf --list-dir agent-socket)"
    								ssh "$remote" "systemctl --user stop gpg-agent.socket gpg-agent.service"
    								ssh -R "$remote_sock:$local_sock" "$remote" "$@"
    							}
  '';

  shellAliases = {
    n = "nvim";
    t = "tmux";
    ll = "ls -lh";
    l = "ls";
    g = "grep";
    k = "kubectl";
    jfu = "journalctl -f -u";
    slu = "sudo systemctl list-units";

    # git aliases
    gfa = "git fetch --all";
    ga = "git add .";
    gca = "git add . && git commit -am";
    gpo = "git push origin";
    gpob = "git push origin $(git branch | grep \\* | awk '{ print $2 }')";
    gp = "git pull";
    gs = "git status";
    gsw = "git switch";
    gclean = "git branch -D $(git branch | grep -v \\* | grep -v main | grep -v master)";

    tarz = "tar --zstd";
    venv = "source .venv/bin/activate";
    necho = "echo -n";

    pwgen-secure = "pwgen -1cns 16";
  };
in
{
  homeModules.shell =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      options.programs.shell = {
        enable = lib.mkEnableOption "Enable shell config";
        motd = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          description = "The message of the day to show on login";
          default = null;
        };
        neofetch = lib.mkOption {
          type = lib.types.bool;
          description = "Whether to show neofetch on login";
          default = true;
        };
      };

      config = lib.mkIf config.programs.shell.enable (
        lib.mkMerge [
          {
            home.packages = with pkgs; [
              fastfetch
            ];

            home.shell.enableZshIntegration = true;

            programs.zsh = {
              enable = true;
              autosuggestion.enable = true;
              enableCompletion = true;
              enableVteIntegration = true;

              history = {
                append = true;
                expireDuplicatesFirst = true;
                extended = true;
              };

              oh-my-zsh = {
                enable = true;
                theme = "dallas";
                # plugins = [ ];
              };

              syntaxHighlighting = {
                enable = true;
                highlighters = [
                  "main"
                  "brackets"
                  "root"
                  "cursor"
                  "line"
                ];
              };

              inherit sessionVariables;
              inherit shellAliases;
            };
          }

          (lib.mkIf config.programs.shell.neofetch {
            programs.zsh.initContent = initContent + ''
              							fastfetch
              						'';
          })

          (lib.mkIf (config.programs.shell.motd != null) {
            xdg.configFile."motd".text = config.programs.shell.motd;
            programs.zsh.initContent = initContent + ''
              message_of_the_day="$(cat ${config.xdg.configHome}/motd)"
              echo "$message_of_the_day"
            '';
          })

          (lib.mkIf (config.programs.shell.motd == null && !config.programs.shell.neofetch) {
            programs.zsh.initContent = initContent;
          })
        ]
      );

    };
}
