An example of /etc/nixos/{configuration.nix, hardware-configuration.nix} I'm using.


NixOS on a BTRFS filesystem was installed by...:

- Booting into the graphical 22.11 NixOS installation
- Using GParted to setup the 3 partitions: 1) Boot, 2) Swap, 3) BTRFS full disk.
- Following this guide (up-until enabling erasure on boot) for nixos subvolumes and mounting:
  https://mt-caret.github.io/blog/posts/2020-06-29-optin-state.html
- Later, RAID1 on 2 encrypted blks following this section of this guide:
  https://mutschler.dev/linux/ubuntu-btrfs-raid1-20-04/#create-raid-1-for-root-filesystem-using-btrfs-balance

SSD optimizations have not yet been fully explored.
