{
  description = "Home Manager configuration of shiphan";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-latest.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim-dependencies = {
      url = "git:/home/shiphan/.config/nvim";
      # url = "github:shiphan/nvim-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    /*
      firefox-nightly = {
        url = "github:nix-community/flake-firefox-nightly";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    */
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nvim-dependencies,
      ...
    }@args:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."shiphan" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
          ./modules/theme.nix
          ./modules/shell.nix
          ./modules/desktop-environment.nix
          ./modules/git.nix
          ./modules/dotfiles.nix
          # ./modules/firefox.nix
          ./modules/qemu-windows-vm.nix
          ./modules/qemu-arch-vm.nix
          # ./modules/sway-git.nix
          nvim-dependencies.home-manager-module
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = args;
      };
      formatter.${system} = pkgs.nixfmt-tree;
    };
}
