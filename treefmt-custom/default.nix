{
  pkgs,
  lib,
  customFormatters ? with pkgs; [
    nixfmt-rfc-style
    deno
  ],
}:
pkgs.treefmt.overrideAttrs (previous: {
  nativeBuildInputs = previous.nativeBuildInputs ++ [ pkgs.makeWrapper ];
  postFixup = "wrapProgram $out/bin/treefmt --set PATH ${lib.makeBinPath customFormatters}";
})
