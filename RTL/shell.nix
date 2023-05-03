{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.nodejs
    pkgs.openssl

    pkgs.less
    pkgs.vim
    pkgs.git
  ];

  # ShellHook section for nix-shell
  # https://github.com/Ride-The-Lightning/RTL/blob/master/.github/docs/Application_configurations.md
  shellHook = ''

  export RTL_CONFIG_PATH="/home/edward/NixWorkspace/RTL"
  echo "export RTL_CONFIG_PATH to $RTL_CONFIG_PATH. (looks for RTL-Config.json)"

  export BITCOIND_CONFIG_PATH="/home/edward/NixWorkspace/Bitcoin"
  echo "export BITCOIND_CONFIG_PATH to $BITCOIND_CONFIG_PATH"

  echo "Create data dir if needed."
  mkdir -p /home/edward/NixWorkspace/RTL/data

  export CHANNEL_BACKUP_PATH="/home/edward/NixWorkspace/RTL/data"
  echo "export CHANNEL_BACKUP_PATH to $CHANNEL_BACKUP_PATH"

  export DB_DIRECTORY_PATH="/home/edward/NixWorkspace/RTL/data"
  echo "export DB_DIRECTORY_PATH="/home/edward/NixWorkspace/RTL/data""

  echo "-------------------------------------------"
  echo "            C-Lightning-REST               "
  echo "-------------------------------------------"
  echo "Source: https://github.com/Ride-The-Lightning/c-lightning-REST"
  echo ""
  echo "Build:"
  echo "  1. git clone https://github.com/saubyk/c-lightning-REST"
  echo "  2. cd c-lightning-REST"
  echo "  3. npm install"
  echo ""
  echo "Executable path: cl-rest.js"
  echo "Usage: node cl-rest.js"
  echo ""
  echo "Config:"
  echo "  - Rename 'sample-cl-rest-config.json' to 'cl-rest-config.json'"
  echo "  - Adjust parameters in 'cl-rest-config.json'"
  echo "  - Alternatively, pass parameters via lightningd config"
  echo ""
  echo "Clean-up:"
  echo "  - Stop the server with Ctrl+C"
  echo "  - Remove the 'c-lightning-REST' directory if desired"
  echo "-------------------------------------------"
  echo ""
  echo "----------------------------------------"
  echo "       RTL Core Lightning Setup         "
  echo "----------------------------------------"
  echo "Source: https://github.com/Ride-The-Lightning/RTL/blob/master/.github/docs/Core_lightning_setup.md"
  echo "----------------------------------------"
  echo "1. Build instructions:"
  echo "  - git clone https://github.com/Ride-The-Lightning/RTL.git"
  echo "  - cd RTL"
  echo "  - npm install --omit=dev"
  echo ""
  echo "2. Executable path: "
  echo "  - RTL server: $(pwd)/RTL/rtl"
  echo ""
  echo "3. Usage instructions:"
  echo "  - Start server: node rtl"
  echo "  - Access app: http://localhost:3000"
  echo ""
  echo "4. Configuration paths:"
  echo "  - Data directory: Edit 'dbDirectoryPath' in RTL-Config.json"
  echo "  - Config file: $(pwd)/RTL/RTL-Config.json"
  echo "  - Access macaroon: Set 'macaroonPath' in RTL-Config.json"
  echo ""
  echo "5. Configuration instructions:"
  echo "  - See Core_lightning_setup.md for details on configuring RTL-Config.json"
  echo ""
  echo "6. Clean-up instructions:"
  echo "  - To update: cd RTL; git reset --hard HEAD; git clean -f -d; git pull; npm install --omit=dev"
  echo "  - To remove: rm -rf RTL"
  echo "----------------------------------------"
  '';
}

