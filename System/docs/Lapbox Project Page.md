- # lapbox
- # 1. Overview
- ## Motivation
	- I want a hybrid node and developer desktop.
	- I want to help bring about Bitcoin (and layer-2 et al) developers.
	- I want to learn self-hosting myself.
	- I want to take advantage of cheap, modular, general purpose hardware.
	- I want to own my own data, and create a protected environment for me and my family.
	- I want it generally secured by default, and fault tolerant.
	- I want it mobile.
	- I want it to spark joy.
	- I want it decentralized as possible.
	- I want less dependencies on development. e.g. No Docker!. no accounts needed.
- ## Vision
	- Any Computer, bootstrap into my own server (sans data, of course)
	- It is the center of the network, and we will move with it.
	- ~80% Web Services moved to Local Services.
	- Host local AI, in terminal.
- ## Principles
	- Decentralization is the answer. Self-Host everything.
		- Always on.
		- Build from source if possible, always.
		- Itself is free and open source, even to the AIs.
	- Keep it simple, silly.
		- Security, macro to micro. Secure the whole network before securing per application. Encrypt the whole disk.
		- Simple folder structures. No unnecessary layers between the OS and a service.
		- Don't create layers between the code/configuration and the operation of the service
	- Do not encumber the development progress, within reason of course.
		- Provide the consistent framework for changes, but don't be so restrictive
		- The project is aimed for learning developers and learning operators. 'Learn as you go' is the point.
	- Severity: Mini-Production.
		- There will be a bit of Bitcoin on it.
		- There will be personal data on it. I will depend on it every day. My family we will depend on it within our household. My daughter will be using it without her knowing. A new Bitcoin developer may be using it. It's a good, sound computing model
		- Itself is not a general purpose, device. No browsing or idling. It's business time, sort of.
		- Down-time is paintime. Up-time is not paintime. Getting from Down to Up is as painless as possible.
- ## Use Cases
	- Persistent, At Home, Always on, Fault Tolerant Home Server (Home Server)
	- On Demand, reproducible, development environment (Cloud Dev Desktop)
	- Replicable Deployments (YetAnotherNodeOffering, ya know?) (Services Operations)
	- Technology Operations Hub (Dashboards and Monitoring)
	- Home-Hosted internet (Our private corner of cyberspace)
- ## Notes on Related Projects
  collapsed:: true
	- nix-bitcoin.
		- Seems geared towards cloud-based hosting of binary-released modules. Doesn't include the 'cloud-dev-desktop' function for building and testing service's source code.
		- Real-world production node operations. Scalable deployment to many hosts.
		- Security first model of NixOS execution.
	- Prepacked nodes, i.e. Umbrel
		- Proprietary, beautiful and user-friendly front-end for system administration of a node.
		- Provides a restricted view of Services (i.e. AppStore).
		- Geared towards operation on a raspberry pi.
	- Docker
		- Containerization platform of developer environments and services. It's a shitcoin, but it was the best shitcoin we had for a while.
		- Account needed.
		- Docker Hub, of professional and community containers and projects.
		- Professional Docker ecosystem for execution, on desktop or cloud.
	- Coinkite block clock
		- A beautiful art piece to display time chain info and market stats.
		- Expensive for what it does, ($300).
- # 2. Design
- ## High-Level. Hardware and Network
	- ### Used Thinkpads as Servers.
		- Built-in battery for power backup.
		- Dual-storage drives for disk backup.
		- Ethernet and wifi for network backup.
		- Mobile by design, with a screen, keyboard, and trackpad.
		- Previously used enterprise-grade equipment.
			- Makes for a long firmware lifecycle. OEM support.
			- Makes it a lower cost option due to wholesale and company asset liquidation
		- Modular and fixable components. Be your own IT department. Source parts to replace.
	- ### Secure in Broad Strokes.
		- Encrypt the Harddisk.
		- VPN the network interface.
		- Use a Hardware Wallet. Externalize the cryptographic keys.
	- ### Give it a name.
		- mDNS, Pegging the host of the lapbox.  e.g. lapbox.local
		- Set the system's timezone.
	- ### Alternative options.
		- Micro form factor PCs plugged into the router. But no screen, no inputs, hard-wired power, might not have wifi. Also inexpensive and plentiful though. Available off the shelf, or from the bin.
		- Fuck single board computers as servers.
- ## High-Level. Software and Configuration
	- ### System Source Code
		- BootLoader
		- NixOS
		- NixPkgs
			- Other Pkg Caches.
	- ### Application Source Code
		- NixPkgs built-in modules
			- optionally, bitcoin-nix modules
		- A Cloud Desktop as a Git Super Project
			- ...Git Sources of many Services...
	- ### Application Execution
		- Services architecture with systemd.
	- ### Interfacing with the Computer
		- Assume that the screen is not used. It is a monitoring terminal or splash screen. System could be a headless box.
		- SSH mainly. Use TMux sessions as the desktop environment Persist the sessions, and always attach to them, one-session-per-user. MOSH to improve the desktop experience.
		- While coding, the SuperProject can be rsync-ed to the host to transfer changes. Lean on Nix providing reproducible build environments. Changes can be immediately tested in an live execution environment.
		- Services could provide their own front-end to browse, if available. e.g. mempool, ride-the-lightning.
- # 3. Details
- ## Disk Configuration
	- The storage and volumes on it. As NixOS suggests.
		- P1 boot
		- P2 NixOS partition
	- No Swap drive, as the Lapbox server should be Always On. If it's off, then it should recover to a working state by itself.
	- Drive can be encrypted by LUKS as part of NixOS graphical install wizard
	- Raid1 is done by Software through Linux between 2 identically sized disks.
		- Both drives would have the same boot partition setup on both.
		- The NixOS partition is a grouped volume, and setup for Raid.
		- The Raid1 system is then mounted during one of the 2 boot sequences.
	- It's undecided at this time the separation of 'personal home services data (like files and photos and notes)' and 'financial services data (like the timechain, or channel states)'. Following the KISS principle, let's go with 'lump it together'. and migration can occur later when we decide what to do.
	- "Software RAID for the entire disk including boot loader has some big warnings that are difficult to explain. You're better off using btrfs installing one big drive then make particular important directories like LN database raid-1 with a smaller disk. This is the easiest path." - tweet#1654513030519226368
	- #[[Lapbox Data Classification]]
-
- ## NixOS Configuration
	- NixOS is a system configuration at `/etc/nixos/`
		- A NixOS config
		- A autogenerated Hardware configuration
	- *Lapbox will change to a minimum NixOS config and import from the SuperProject*.     etc nixos --> NixWorkspace/Lapbox/systemconfig.nix && NixWorkspace/Lapbox/serviceconfig.nix
	- *The Hardware configuration will not be changed, as it was autogenerated*
	- ## Setup
		- **NixOS Flake Steps:**
		  1. `cd /home/lapbox/` && `git clone edwardhodl:lapbox --recursive`. Pulls folders and flakes and configs. Submodules.
		  2. nixos configuration import lapbox. `/etc/nixos/configuration.nix` --> `/lapbox/lapbox/system/configuration.nix`
		  3. (opt) udev rule to rename raid device
		  4. (opt) configure services
		  5.  `nixos-rebuild switch`
		- **Under the Hood NixOS we expect**
		  1. lapbox user. Home Dir: `/home/lapbox/`
		  2. BTRFS, creates subvol at (root)`/lapbox/`
		  3. MDADM, creates software raid on `/lapbox/`. Enable mount mdadm during init at ram
		  4. symlink `/lapbox/` to `/home/lapbox/lapbox/`
		- **Nix Flake Services:**
		  3. `nix flake build`. Each project is built
		  4. Systemd files are created.
		  5. services are enabled. and startup.
		  6. install *-cli to path.
		- **Monitoring:**
		  1. install path to jump to journal logging
		  2. shell script to watch services.
		  3. net. vpn.
		  4. CPU. Ram. Disk.
- ## Lapbox Git SuperProject
	- TODO Lapbox Git SuperProject
	- The SuperProject is a top-level git repository. It takes the place of the `~/NixWorkspace/` concept of a developer desktop. `/home/<user>/NixWorkspace`
	- Services are each a SubModule to the SuperProject
	- There may be multiple submodules for a service.
	- The Folder structure will be as follows:
	  ```
	  ~/Lapbox/ - SuperProject top-level Git
	  ~/Lapbox/services.nix - enable or disable services.
	  ~/Lapbox/System/ - NixOS and Host configuration
	  ~/Lapbox/System/{net.nix, sqldb.nix, ssh.nix, session.nix, power.nix, tmux.nix, etc.} - built-in module confs, dev-desktop conf, shell scripts
	  
	  ~/Lapbox/<Service>/ - Dev and Execution Envrionment for <Service>
	  ~/Lapbox/<Service>/<git submodule repo (s)> - Another Git repo as a submodule. Source code
	  ~/Lapbox/<Service>/shell.nix - A shell configuration to build the repo, help docs, scripts and aliases.
	                               - execution configuration to run the service, e.g. Firewall ports
	                               - systemD unit configuration for the service.
	                               - alises to run the executible with flags to Lapbox paths.
	  ~/Lapbox/<Service>/<service.conf> - The service configuration file
	  ~/Lapbox/<Service>/data/ - The services data-directory or database, if required. 
	  ~/Lapbox/<Service>/log/ - log output of the service
	  ~/Lapbox/<Service>/bin/ - Symlink to the service's built executibles
	  ~/Lapbox/<Service>/secret/ - private keys, HSM data, certificates, signatures, etc.
	  
	  ```
	- Note: **/NixWorkspace/ = /Lapbox/**
- ## An example Service: Bitcoin Core
	- A Service contains any or all of:
		- Development and Execution Environment: `/home/user/Lapbox/Bitcoin/shell.nix`
			- (nix-shell as above)
			- (QEMU containerization)
		- Source code: https://github.com/bitcoin/bitcoin
			- (Testing)
		- Binary Executable (build or reference): symlink from submodule after building: `/home/user/Lapbox/Bitcoin/bin/{bitcoind bitcoin-cli}`
			- (Signature Verification)
		- Service Config: `conf=/home/user/Lapbox/Bitcoin/bitcoin.conf`
		- Service Data directory: `bitcoin's Blocks, Peers, Mempool: datadir=/home/user/Lapbox/Bitcoin/data/`
		- Service key directory: `bitcoin's wallet folder: walletdir=/home/user/Lapbox/Bitcoin/crypto/`
		- Execution Configuration (systemd unit): *it's own file or part of shell.nix*
		- Application Interface
			- (Command line interface): bin in `/home/user/Lapbox/Bitcoin/bin/bitcoin-cli`
			- (TCP / UDP connection, over HTTP or HTTPS). Firewall ports in `shell.nix`
		- Logs: bitcoin daemon's log: `debuglogfile=/home/user/Lapbox/Bitcoin/log/debug.log`
- ## Services Info.
	- Bitcoin - A Bitcoin Node
	- ElectRS - A Electrum Server - A TX indexed DB
	- CoreLightning - A Lightning Node
	- RideTheLIghtning - A Lightning Node Front-end for management of wallet, channels, peers.
	- Mempool - A Bitcoin mempool explorer
	- Personal Home Server:
		- NextCloud - File sync. And it's platform of applications
		- PhotoPrism - Photo sync, metadata and search.
		- BitWarden - Password store
	- LLM AI Models - A GPT-like service.
	- Nostr Relay - A "Notes and other stuff" relay, and note cache. Social.
	- Remote NixStore - Serve the Lapbox's nix store
- ## Security.
	- 'pure' environments everywhere I go
	- Network isolated.  VPN and Firewall.
	- Mini-Prod. No general purpose browsing.
	- Containers per service, resource allocated and network isolated.
- ## Monitoring.
	- Dashboards, accessible in the terminal:
		- All-up 1 Dashboard summary
		- Hardware: Power, CPU, Ram, Disk, Raid1 status, Devices List, Uptime.
		- Network: Network Interfaces, Bandwidth, connections, TCP/UDP port list, VPN/Tor
		- Services: One per service. Submodule branch. Application state. Data size on disk. Network details, bandwidth, connections. Log exert. Log size on disk.
	- Lapbox Main Screen could be used to view dashboard, but this is optional.
	- Blockclock like art. Visualizers:
		- block height
		- mempool
		- channel states.
		- node graphs.
- ## Recovery
	- Whole Hardware.
		- The entire Lapbox system will be defined in the SuperProject except for: a) datadir, b) wallet. As such, a whole-hardware recovery would look like setting up another Thinkpad to load Lapbox, and get it running in an initial state, with the same configuration.
		- datadir and wallet backups should be treated like a data migration, or from an offline store to recover them.
	- Disk
		- A Software raid 1 system is a mirrored volume across 2 disks. we should have monitoring tell us when one disk fails, so it can be replaced.
	- Network
		- Connections for Multiple network interfaces could allow a fall-back behavior from a primary to a secondary.
	- Services
		- The SuperProject should provide a straight-forward, single location to define the target-state of services, whether they are: `AutoStart` or `Manual`
	- Hardware Wallet
		- I want to be able to use the familiar Bitcoin self-custody hardware wallet best-practises with Lapbox.
- # 4. Milestones
	- ## Code Repository Goals
		- 1. Lapbox is a document. Short and sweet execution. Getting started for the first time, but really it's so good it's every time. Drop knowledge, simply and effectively and sweet. a) Overview, b) Concept and Plan, c) Steps
		- 2. Lapbox workspaces, data dirs, configurations, logs. Shrink the paths, 1 folder, 1 container.
		- 3. Lapbox is a collection of configurations in a repository.
		- 4. servicesd unit files for services. Hardware is always on, and services recover.
		- 5. 1 folder, 1 container. Hardware resource allocation of services
	- ## Hardware Goals
		- DONE 1 system, Raid 1
		- (2) Recover Lapbox on another Computer.
	- ## Services Goals
		- Bitcoin
			- CLI
			- through the Hardware interface.
		- Transaction DB
		- Mempool explorer
		- Lightning Node
			- CLI
		- Wallets, Node Front End Interface (RTL)
			- Private Key Access
			- Hardware Wallet Interface
		- Transaction Scheduler. Cron jobs.
		- Self host for home applications.
			- Private data dir?
			- NextCloud. File sync.
				- Logseq.
			- PhotoPrism for Photos.
				- Dropbox
				- OneDrive
		- Self host a Large Language Model.
			- gpt4all
		- A Nostr Server
			- Relay and Buffer.
	- ## Monitoring Goals
		- 1 Top level, then many 1-page drill downs
			- Hardware. Power, Network, System Devices. CPU, RAM, GPU. Hardware Interface Status. Services status.
			- A Service. Service status. Console output. The application's resource usage (Container status,)
			- Administrative console logs. Uptime, users access, environment history. Connected devices.
		- A splash screen with the time, date, and the weather.
		- Mempool visualizer
		- Channel status visualizer.