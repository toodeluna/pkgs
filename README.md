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
      # You can now use the `packages` attribute set of this flake or use one of the `overlays` attributes to add all the packages to your nixpkgs instance.
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

## Plymouth GIF Theme

A [Plymouth](https://www.freedesktop.org/wiki/Software/Plymouth/) theme that
shows a custom GIF on boot. Not exactly useful, but pretty fun. By default it
uses [this GIF](./plymouth-gif-theme/bounce.gif) of Madeline from the game
[Celeste](https://www.celestegame.com/), but you can specify a custom GIF by
overriding the `gif` attribute.

```nix
{ pkgs, ... }@inputs:
{
  boot.plymouth = {
    enable = true;
    theme = "plymouth-gif-theme";
    themePackages = [
      # Use the default GIF:
      inputs.toodeluna-pkgs.x86_64-linux.plymouth-gif-theme

      # Or specify a custom GIF:
      (inputs.toodeluna-pkgs.x86_64-linux.plymouth-gif-theme.override { gif = ./path/to/custom/file.gif })
    ];
  };
}
```
