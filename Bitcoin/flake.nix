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
        packages.bitcoin = pkgs.stdenv.mkDerivation rec {
          pname = "bitcoin";
          version = "0.1.0";

          # (Custom) Unpack Phase
          unpackPhase = ''
            runHook preUnpack
            echo "Running custom unpack phase"
            runHook postUnpack
          '';

          # (Custom) Configure Phase
          configurePhase = ''
            runHook preConfigure
            echo "Running custom configure phase"
            runHook postConfigure
          '';

          # (Custom) Build Phase
          buildPhase = ''
            runHook preBuild
            echo "Running custom build phase"
            runHook postBuild
          '';

          # (Custom) Check Phase
          checkPhase = ''
            runHook preCheck
            echo "Running custom check phase"
            runHook postCheck
          '';

          # (Custom) Install Phase
          installPhase = ''
            runHook preInstall
            mkdir -p $out
            echo "Placeholder" > $out/placeholder.txt
            runHook postInstall
          '';

          # Disable each standard-environment, 'genericBuild' phase.
          #  https://nixos.org/manual/nixpkgs/stable/#sec-stdenv-phases
          dontUnpack = false;           # unpack
          dontPatch = true;
          dontConfigure = false;	# configure
          dontBuild = false;		# build
          doCheck = true;		# check
          dontInstall = false;		# install
          dontFixup = true;
          doInstallCheck = false;
          dontCopyDist = true;
        };

        devShells.default = import ./shell.nix {inherit pkgs; };
      }
   );
}
