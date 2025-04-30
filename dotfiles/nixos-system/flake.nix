{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # nixos-hardware.url = "github:nixos/nixos-hardware/master";
  };

  outputs =
    { self, nixpkgs, ... }@args:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations."nixos-laptop" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = args;
        modules = [
          ./configuration.nix
          ./modules/users.nix
          ./modules/boot.nix
          ./modules/suspend.nix
          ./modules/display-manager.nix
          ./modules/hyprland.nix
          ./modules/fonts.nix
          ./modules/framework-laptop.nix
          # args.nixos-hardware.nixosModules.framework-13-7040-amd
        ];
      };
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
    };
}
