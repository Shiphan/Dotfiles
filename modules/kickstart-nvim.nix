{ pkgs, ... }:

{
  programs.neovim.enable = true;
  home.packages = with pkgs; [
    ripgrep

    clang-tools
    rust-analyzer
    rustfmt
    gopls
    jdt-language-server
    kotlin-language-server
    pyright
    postgres-lsp
    arduino-language-server
    bash-language-server
    haskell-language-server
    ghc
    nil
    nixd
    hyprls
    nodePackages.vscode-json-languageserver
    superhtml
    (callPackage ../pkgs/npm/default.nix { }).vscode-langservers-extracted
    htmx-lsp
    typescript-language-server
    php84Packages.psalm
    phpactor
    templ
    svelte-language-server
    lua-language-server
    stylua
    marksman
  ];
}
