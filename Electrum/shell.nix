{ pkgs ? import <nixpkgs> {
    overlays = [
      (import (fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz"))
    ];
} }:

with pkgs;

mkShell {
  buildInputs = [
    cargo
    rustc
    rust-analyzer
    llvmPackages.bintools
    gcc12
    rust-bindgen
    cmake
    stdenv
    git
    rocksdb
    gflags
    snappy
    zlib
    # haskellPackages.bz2
    lz4
    zstd
  ];

  shellHook = ''
  alias electrs='/home/edward/NixWorkspace/Electrum/electrs/target/release/electrs --conf=/home/edward/NixWorkspace/Electrum/config.toml --db-dir=/home/edward/NixWorkspace/Electrum/data/'
  alias

  export LIBCLANG_PATH="${llvmPackages.libclang.lib}/lib"
  echo "Set LIBCLANG_PATH envvar: $LIBCLANG_PATH"

  # https://github.com/NixOS/nixpkgs/issues/52447#issuecomment-853429315
  export BINDGEN_EXTRA_CLANG_ARGS="-isystem ${llvmPackages.libclang.lib}/lib/clang/${lib.getVersion clang}/include"
  echo "Set BINDGEN_EXTRA_CLANG_ARGS: $BINDGEN_EXTRA_CLANG_ARGS"
  
  cd electrs
  
# Banner
  echo "========================================================"
  echo "               ELECTRS DEVELOPMENT SETUP                "
  echo "========================================================"
  echo

  # Source location
  echo "Source location: https://github.com/romanz/electrs"
  echo

  # Build instructions
  echo "----------------- BUILD INSTRUCTIONS ------------------"
  echo "1. Build the project: cargo build --release --locked"
  echo "2. The built binary will be located at 'target/release/electrs'"
  echo

  # Executable paths
  echo "------------------ EXECUTABLE PATHS -------------------"
  echo "Electrs binary: ./target/release/electrs"
  echo

  # Usage instructions
  echo "-------------- USAGE INSTRUCTIONS FOR EXECUTABLES ------"
  echo "Run electrs: ./target/release/electrs [OPTIONS]"
  echo "For a list of options, run: ./target/release/electrs --help"
  echo

  # Configuration paths
  echo "------------------ CONFIGURATION PATHS -----------------"
  echo "Data directory: ~/.electrs/data"
  echo "Configuration file: ~/.electrs/electrs.conf"
  echo

  # Configuration instructions
  echo "------------- CONFIGURATION INSTRUCTIONS ---------------"
  echo "Edit the configuration file at ~/.electrs/electrs.conf"
  echo "Refer to the project's documentation for available options."
  echo

  # Clean-up instructions
  echo "------------------ CLEAN-UP INSTRUCTIONS ---------------"
  echo "To clean up the build artifacts, run: cargo clean"
  echo

  # Additional notes
  echo "--------------- ADDITIONAL NOTES/PERTINENT -------------"
  echo "Make sure to consult the project's README for more detailed information."
  echo "========================================================"
'';

}

