{ pkgs, ... }:

{
  programs.neovim.enable = true;
  home.packages = with pkgs; [
    vimPlugins.lazy-nvim

    # lsp
    clang-tools
    rust-analyzer
    gopls
    jdt-language-server
    kotlin-language-server
    pyright
    postgres-lsp
    arduino-language-server
    bash-language-server
    nil
    nixd
    hyprls
    nodePackages.vscode-json-languageserver
    superhtml
    # (callPackage ../pkgs/npm/node-env.nix { }) # vscode lsp
    htmx-lsp
    templ
    svelte-language-server
    lua-language-server
    stylua
  ];
}
