{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  }: let
    nixpkgs-args = {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    pkgs = import nixpkgs nixpkgs-args;
    pkgs-unstable = import nixpkgs-unstable nixpkgs-args;
  in {
    homeConfigurations."minecraft@potato-server" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home.nix
      ];
      extraSpecialArgs = {
        inherit pkgs-unstable;
      };
    };
  };
}
