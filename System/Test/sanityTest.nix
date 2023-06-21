let
  pkgs = import <nixpkgs> {};

  # Single source of truth
  hostname = "thinkbox";

  # NixOS module shared between server and client
  sharedModule = {
    imports = [ ../configuration.nix ];
  };

in pkgs.nixosTest ({
  name = "sanityTest";
  enableOCR = true;

  nodes = {
    machine = { config, pkgs, lib, ... }: {
      imports = [ sharedModule ];
      config = {
        lapbox.hostname = lib.mkForce "${hostname}";
      };
    };
  };

  # Disable linting for simpler debugging of the testScript
  skipLint = true;

  # machine objects: https://nixos.org/manual/nixos/stable/index.html#ssec-machine-objects
  testScript = ''
    import json
    import sys

    # Test that the machien starts and would be reachable
    machine.start()  

    # openssh
    machine.wait_for_unit("sshd.service")
    machine.wait_for_open_port(22)

    # avahi
    machine.wait_for_unit("avahi-daemon.service")

    # firewall
    machine.wait_for_unit("firewall.service")

    # console sanity checks
    machine.wait_until_succeeds("ls", 100)
    assert "${hostname}" in machine.succeed("hostname"), "configured hostname does not match 'hostname' command output."
  '';
})