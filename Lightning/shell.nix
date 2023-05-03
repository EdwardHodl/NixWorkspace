{ pkgs ? import <nixpkgs> {} }:

let
  python3Env = pkgs.python3.withPackages (p: [p.bitcoinlib p.Mako]);
in
pkgs.mkShell {
  buildInputs = [
    pkgs.gdb
    pkgs.sqlite
    pkgs.autoconf
    pkgs.clang
    pkgs.libtool
    pkgs.gmp
    pkgs.sqlite
    pkgs.autoconf
    pkgs.autogen
    pkgs.automake
    pkgs.libsodium
    python3Env
    pkgs.valgrind
    
    pkgs.git
    pkgs.cacert # for SSL/TLS certificates while fetching from Git.
    pkgs.zlib
    pkgs.gettext
    pkgs.less
    pkgs.vim
    pkgs.man
    pkgs.jq
 ];

  shellHook = ''
    echo "Loaded Lightning shellHook"
    alias bitcoin-cli='/home/edward/NixWorkspace/Bitcoin/bitcoin/src/bitcoin-cli -datadir=/home/edward/NixWorkspace/Bitcoin/data/ -conf=/home/edward/NixWorkspace/Bitcoin/bitcoin.conf'

    alias lightningd='/home/edward/NixWorkspace/Lightning/lightning/lightningd/lightningd --conf=/home/edward/NixWorkspace/Lightning/cln-mainnet.config --lightning-dir=/home/edward/NixWorkspace/Lightning/data'
    alias lightning-cli='/home/edward/NixWorkspace/Lightning/lightning/cli/lightning-cli --conf=/home/edward/NixWorkspace/Lightning/cln-mainnet.config --lightning-dir=/home/edward/NixWorkspace/Lightning/data'
    alias

    echo "Add SSL_CERT_FILE environment variable"
    export SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
   
    echo "Running 'cd lightning'"
    cd lightning

  echo "-------------------------------------------"
  echo " Core Lightning (CLN) Project Information "
  echo "-------------------------------------------"
  echo "Source Location: https://github.com/ElementsProject/lightning/"
  echo "Documentation: https://lightning.readthedocs.io/"
  echo
  echo "-------------"
  echo " Build Steps "
  echo "-------------"
  echo "1. Install dependencies"
  echo "2. Run './configure'"
  echo "3. Run 'make'"
  echo
  echo "-----------------"
  echo " Executable Paths "
  echo "-----------------"
  echo "lightningd: src/lightningd/lightningd"
  echo "lightning-cli: cli/lightning-cli"
  echo
  echo "-------------------"
  echo " Usage Instructions "
  echo "-------------------"
  echo "1. Start lightningd: './src/lightningd/lightningd --network=bitcoin --log-level=debug'"
  echo "2. Use JSON-RPC interface via lightning-cli: './cli/lightning-cli <command>'"
  echo
  echo "-----------------"
  echo " Configuration Paths "
  echo "-----------------"
  echo "Data Directory: '~/.lightning/' or '~/.lightning/bitcoin/'"
  echo "Configuration File: 'config'"
  echo
  echo "---------------"
  echo " Clean-up Steps "
  echo "---------------"
  echo "1. Stop lightningd"
  echo "2. Remove the data directory: 'rm -rf ~/.lightning/'"
  echo "3. Remove the compiled binaries: 'make clean'"
  echo "-------------------------------------------"
  '';
}

