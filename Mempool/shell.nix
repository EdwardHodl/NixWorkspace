{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "MempoolShell";

  buildInputs = with pkgs; [
    # Add your dependencies here, e.g.:
    # pkgs.python3
    nodejs
    nodePackages.npm

    rsync

    git
    vim
    less
  ];

  shellHook = ''


    export MEMPOOL_CONFIG_FILE="/home/edward/NixWorkspace/Mempool/mempool-config.json"
    echo "Set MEMPOOL_CONFIG_FILE to $MEMPOOL_CONFIG_FILE"

    # Add any shell customizations here, e.g.:
    # export VARNAME=value
    echo "Loaded MempoolShell"
echo "====================================="
echo "==== Mempool Project Documentation ===="
echo "====================================="
echo "1. Clone Mempool Repository"
echo "   git clone https://github.com/mempool/mempool"
echo "   cd mempool"
echo "============= Backend ==============="
echo "   cd mempool/backend"
echo ""
echo "2. Configure Bitcoin Core"
echo "   Set txindex, server, rpcuser and rpcpassword in bitcoin.conf"
echo ""
echo "3. Configure Electrum Server (optional)"
echo "   Choose an Electrum Server implementation and configure it"
echo ""
echo "4. Configure MariaDB"
echo "   Install MariaDB, create a database and grant privileges"
echo ""
echo "5. Prepare Mempool Backend"
echo "   Install dependencies, build the backend and configure settings"
echo "   cd backend"
echo "   npm install"
echo "   npm run build"
echo "   cp mempool-config.sample.json mempool-config.json"
echo ""
echo "6. Run Mempool Backend"
echo "   npm run start"
echo "   (Optional) MEMPOOL_CONFIG_FILE=/path/to/mempool-config.json npm run start"
echo ""
echo "7. Set Up Mempool Frontend"
echo "   Follow the frontend setup instructions"
echo ""
echo "======= Frontend  ======="
echo "->  Build the Frontend"
echo "   cd frontend"
echo "   npm install"
echo "   npm run build"
echo ""
echo "-> Specify Website"
echo "   npm run config:defaults:mempool"
echo "   npm run config:defaults:liquid"
echo "   npm run config:defaults:bisq"
echo ""
echo "-> Run the Frontend"
echo "   Quick-Dev (front only): npm run serve:local-prod"
echo "   Development: npm run serve (tcp port 4200)"
echo "   Production: Put the contents of 'dist/' onto your web server"
echo ""
echo "-> Test"
echo "   npm run config:defaults:mempool && npm run cypress:run"
echo "   npm run config:defaults:mempool && npm run cypress:open"
echo ""
echo "======================================"
alias mempoolbackend='cd mempool/backend && npm run start'
alias mempoolfrontend='cd mempool/frontend && npm run serve'
alias
  '';
}

