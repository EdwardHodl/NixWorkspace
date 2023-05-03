{
  description = "Lapbox's Bitcoin nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

    # Wrap shell.nix with flake.nix.
    # - https://nixos.wiki/wiki/Flakes#Super_fast_nix-shell
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = import ./shell.nix {inherit pkgs; };
      }
   );
}
