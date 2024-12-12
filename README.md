# 📦 Packages

A Nix flake containing custom Nix derivations. These are mostly made for my own
use cases, but can be used by anyone if they seem useful. To use them, simply
add this flake as an input to your own flake:

```nix
{
  description = "Your flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    toodeluna-pkgs = {
      url = "github:toodeluna/pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, toodeluna-pkgs }:
    {
      # You can now use the `packages` attribute set of this flake.
    };
}
```

Below is a list of descriptions and docs for all the packages exported by this
flake.

## Treefmt Custom

Allows you to wrap [treefmt](https://treefmt.com/latest/) with a list of
formatter packages of your choice so that you don't have to install them
globally. By default it wraps the formatters needed for a Nix flake repo (nixfmt
for .nix files and deno for markdown files), but you can specify custom
formatters by overriding the `customFormatters` attribute.

```nix
{
  # Use the default formatters:
  formatter.x86_64-linux = toodeluna-pkgs.packages.x86_64-linyx.treefmt-custom;

  # Or specify custom formatters:
  formatter.x86_64-linux = toodeluna-pkgs.packages.x86_64-linux.treefmt-custom.override {
    customFormatters = [ /* List your formatter packages here */ ];
  };
}
```
