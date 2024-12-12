{
  description = "My custom Nix packages.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      mkPackage = system: path: nixpkgs.legacyPackages.${system}.callPackage (import path) { };
    in
    {
      formatter = {
        x86_64-linux = self.packages.x86_64-linux.treefmt-custom;
      };

      packages = {
        x86_64-linux.plymouth-gif-theme = mkPackage "x86_64-linux" ./plymouth-gif-theme;
        x86_64-linux.treefmt-custom = mkPackage "x86_64-linux" ./treefmt-custom;
      };

      overlays = {
        x86_64-linux = (_: _: self.packages.x86_64-linux);
      };
    };
}
