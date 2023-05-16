# shell.nix

{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation {
  name = "NostrShell";
  buildInputs = [ nix git ];
  shellHook = ''
    # Add custom shell initialization here
    cd primal-caching-service
    cat README.md

    export PRIMALSERVER_HOST="0.0.0.0"
    echo "set PRIMALSERVER_HOST to $PRIMALSERVER_HOST (bind to all LAN)"

    export PRIMALSERVER_STORAGE_PATH="/home/edward/Nostr/data"
    echo "set PRIMALSERVER_STORAGE_PATH to $PRIMALSERVER_STORAGE_PATH"

    alias primal="nix develop -c sh -c '\$start_primal_caching_service'"
    alias
  '';
}
