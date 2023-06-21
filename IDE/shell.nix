{ pkgs ? import <nixpkgs> { } }:

# Dependencies from bitcoin/bitcoin
# https://github.com/bitcoin/bitcoin/blob/master/doc/dependencies.md

pkgs.mkShell {
  buildInputs = [
    pkgs.vim
    pkgs.less
    pkgs.git
    pkgs.which
    pkgs.man
    pkgs.nix

# https://github.com/nix-community/nixd/blob/main/docs/user-guide.md
shellHook = ''
  echo "----------------------------------"
  echo "NixD Project Documentation"
  echo "----------------------------------"
  echo "Source location: https://github.com/nix-community/nixd"
  echo "----------------------------------"
  echo "Build Instructions:"
  echo "nix-build --expr 'with import <nixpkgs> { }; callPackage ./. { }'"
  echo "or for Nix Flakes: nix build -L .#"
  echo "----------------------------------"
  echo "Usage Instructions:"
  echo "Refer to the official documentation at https://github.com/nix-community/nixd/blob/main/docs/user-guide.md"
  echo "----------------------------------"
'';

}
