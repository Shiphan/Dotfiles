{ pkgs, ... }:

{
  home.packages = with pkgs; [
    figlet
  ];
  home.shellAliases = {
    "ls" = "ls --color=auto";
    "grep" = "grep --color=auto";
    "ll" = "ls -lh";
    "lla" = "ls -lha";
    "lsa" = "ls -ha";
    ":q" = "exit";
    # "trash" = "gio trash";
  };
  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      initExtra = ''
        PS1=' \[\e[0;38;2;180;200;220m\]\[\e[1;38;2;64;64;64;48;2;180;200;220m\]\u\[\e[0;38;2;64;64;64;48;2;180;200;220m\] @\h \[\e[0;38;2;20;44;68;48;2;180;200;220m\]\[\e[1;38;2;180;200;220;48;2;20;44;68m\]\W $(if [ -d .git ]; then echo " "; else echo "󰉋 "; fi)\[\e[0;38;2;20;44;68;48;2;180;200;220m\]\[\e[1;38;2;64;64;64;48;2;180;200;220m\] \$\[\e[0;38;2;180;200;220m\]\[\e[0m\] '

        wdi() {
            if [[ $# -le 1 ]]; then
                dir=$(wtdwi "$1")
                [[ $? -eq 0 ]] && cd "$dir"
            else
                echo "too many arguments"
            fi
        }

        echo
        figlet -t -f smslant " NixOS  $(date +"%I:%M %p")"
        echo
      '';
    };
    readline = {
      enable = true;
      includeSystemConfig = true;
      variables = {
        "completion-ignore-case" = true;
      };
      bindings = {
        "\\e[A" = "history-search-backward";
        "\\e[B" = "history-search-forward";
      };
    };
    zsh = {
      enable = true;
      # defaultKeymap = "viins";
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      /*
        plugins = [
          {
            name = "zsh-vi-mode";
            src = pkgs.zsh-vi-mode;
            file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
          }
        ];
      */
      initContent = ''
        zstyle ':completion:*' menu select
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

        bindkey "^[OA" history-beginning-search-backward
        bindkey "^[[A" history-beginning-search-backward
        bindkey "^[OB" history-beginning-search-forward
        bindkey "^[[B" history-beginning-search-forward
        bindkey "^K" vi-kill-eol

        setopt interactivecomments
        setopt PROMPT_SUBST
        PROMPT=' %F{#b4c8dc}%B%F{#404040}%K{#b4c8dc}%n%b @%M %F{#142c44}%B%F{#b4c8dc}%K{#142c44}%~%b%F{#142c44}%K{#b4c8dc}%B%F{#404040} $(git status &> /dev/null; if [ $? -eq 0 ]; then echo " "; else echo "󰉋 "; fi)$(git branch --show-current 2> /dev/null)%b%F{#b4c8dc}%k%f
         %(!.#.$) '

        wdi() {
            if [[ $# -le 1 ]]; then
                dir=$(wtdwi "$1")
                [[ $? -eq 0 ]] && cd "$dir"
            else
                echo "too many arguments"
            fi
        }

        echo
        figlet -t -f smslant " NixOS  $(date +"%I:%M %p")"
        echo
      '';
    };
  };
}
