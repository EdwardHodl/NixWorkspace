{ pkgs ? import <nixpkgs> { } }:

# Dependencies from bitcoin/bitcoin
# https://github.com/bitcoin/bitcoin/blob/master/doc/dependencies.md

pkgs.mkShell {
  buildInputs = [
    pkgs.vim
    pkgs.less
    pkgs.git
    pkgs.pkg-config
    pkgs.zlib
    pkgs.which
    pkgs.man

    pkgs.autoconf
    pkgs.automake
    pkgs.llvmPackages.libcxxStdenv
    pkgs.gcc12
    
    pkgs.boost
    pkgs.libevent
    pkgs.linuxKernel.packages.linux_hardened.kernel

    pkgs.libtool
    pkgs.hexdump
    
    pkgs.python38 # for Tests

    # for GUI
    pkgs.fontconfig
    pkgs.freetype
    pkgs.qrencode
    pkgs.qt6.qt5compat
    pkgs.qt6.full

    # for Networking
    pkgs.libnatpmp
    pkgs.miniupnpc

    # for Events/Notifications
    pkgs.zeromq
    
    # for wallets (database)
    pkgs.db4
    pkgs.sqlite
  ];

# https://github.com/bitcoin/bitcoin/blob/master/doc/bitcoin-conf.md
  shellHook =
  ''
    alias bitcoind='/home/edward/NixWorkspace/Bitcoin/bitcoin/src/bitcoind -datadir=/home/edward/NixWorkspace/Bitcoin/data/ -conf=/home/edward/NixWorkspace/Bitcoin/bitcoin.conf -walletdir=/home/edward/NixWorkspace/Bitcoin/secret/ -debuglogfile=/home/edward/NixWorkspace/Bitcoin/log/bitcoincore.log'
    alias bitcoin-cli='/home/edward/NixWorkspace/Bitcoin/bitcoin/src/bitcoin-cli -datadir=/home/edward/NixWorkspace/Bitcoin/data/ -conf=/home/edward/NixWorkspace/Bitcoin/bitcoin.conf'
    alias

    echo "Hello shell"
    echo "In Nix Shell: $IN_NIX_SHELL"
    echo "Running on system: $CURRENT_SYSTEM"
    echo "C Compiler, CC: $CC. "; which $CC
    echo "Dynamic Library Linker, LD: $LD. "; which $LD

  echo "────────────────────────────────────────"
  echo "              WELCOME - Bitcoin nix-shell"
  echo "────────────────────────────────────────"
  echo "Build Instructions:"
  echo "  1. git clone https://github.com/bitcoin/bitcoin.git"
  echo "  2. cd bitcoin"
  echo "  3. ./autogen.sh"
  echo "  4. ./configure --without-gui --with-wallet (./configure -help for options)"
  echo "  5. make"
  echo "  6. make check (optional)"
  echo ""
  echo "Executable Paths:"
  echo "  - bitcoind: src/bitcoind"
  echo "  - bitcoin-cli: src/bitcoin-cli"
  echo "  - bitcoin-qt: src/qt/bitcoin-qt"
  echo "  - bitcoin-tx: src/bitcoin-tx"
  echo "  - bitcoin-wallet: src/bitcoin-wallet"
  echo "  - test_bitcoin: src/test/test_bitcoin"
  echo ""
  echo "Usage Instructions:"
  echo "  1. Start: ./src/bitcoind -daemon"
  echo "  2. Stop:  ./src/bitcoin-cli stop"
  echo "    ./src/bitcoin-cli help"
  echo ""
  echo "Configurations:"
  echo "  - Config file: ~/.bitcoin/bitcoin.conf"
  echo "  - Data dir:    ~/.bitcoin"
  echo ""
  echo "Clean-up:"
  echo "  - Clean the build directory: make clean"
  echo "  - Remove generated files from the configure script: make distclean"
  echo "────────────────────────────────────────"

  '';
}
