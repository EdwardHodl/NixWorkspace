# NixWorkspace

## What the Project Does

This project sets up a lightning node on a Thinkpad from source. It is a SuperProject designed to streamline the process of setting up a lightning node.

## Why the Project is Useful

The project is useful as it automates the process of setting up a lightning node, saving users time and effort. It leverages the power of Nix and Nix-shell to ensure a smooth and efficient setup process.

## How Users Can Get Started With the Project

To get started with the project, clone the repository to your local machine. You will need to have Nix and Nix-shell installed. Once cloned, navigate to the project directory and run the setup scripts.

### Using NixPkg
1. clone the project - Copy the source to your computer
2. `git submodule update --init --recursive` - Recursively initialize and/or update nested GitHub projects (submodules)
3. `cd <Service Name>` - nagivate to the service dir
4. `nix-shell --pure` -- drop into a development shell with project dependencies defined in`shell.nix`
5. follow the shellHook helper message to build, configure, and run the project

### Using NixOS
1. Install NixOS
2. Import `NixWorkspace/System/configuration.nix` into `/etc/nixos/configuration.nix`
a. Modify `NixWorkspace/serviceconfig.nix` to enable/disable services you want.
3. (*Optional*) `sudo nixos-rebuild build` - Build the modified system derivation only.
4. `sudo nixos-rebuild switch` - build and switch to the modified system derivation.

### Other Notes
- Use `mosh` and `tmux` to connect (ssh) to your system, and run multiple programs in tabs and panes in a single connection.
- Uses Mullvad for always-on VPN.
- User space configuration is hardcoded to me and my host, `edward@lapbox.local`
- To use a different filesystem for NixOS, your filesystem must be formatted during the NixOS installation on the system. See: `System/docs/hardware/README.md`
- Be sure to setup your Hardware-Configuration from [https://github.com/NixOS/nixos-hardware](https://github.com/NixOS/nixos-hardware)

### My NixWorkspace
![Screenshot of tmux over mosh](/System/docs/assets/screenshottmuxovermosh.jpeg)


## Where Users Can Get Help With the Project

For help with the project, please raise an issue in the GitHub repository. This is the quickest way to get your questions answered or problems resolved.

## Who Maintains and Contributes to the Project

The project is maintained and contributed to by EdwardHodl. Contributions are welcome and appreciated.

## Software Mechanisms Used

The project uses Git submodules, Nix, and Nix-shell to manage dependencies and streamline the setup process. The operating system is NixOS, and services run on systemd.

## Note

Please note that this project is a work in progress. Paths and user configuration are hardcoded at this time. Changes and improvements are ongoing.

YMMV, Thanks for reading. Edward.
