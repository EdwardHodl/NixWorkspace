# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, options, lib, ... }:

{
  imports =
    [
      # enabled with adding the nixos-hardware channel.
      <nixos-hardware/lenovo/thinkpad/e495/default.nix>
      ./secret.nix
      ./power.nix
      ./net.nix
      ./ssh.nix
      ./monitoring.nix
      ../serviceconfig.nix
    ];
  
  config = {
    environment.systemPackages = with pkgs; [ vim less git ];
    nix.settings.experimental-features = ["nix-command" "flakes"];
    nixpkgs.config = {
      permittedInsecurePackages = [
        "nodejs-16.20.0"
      ];
      allowUnfree = true;
    };

    networking.hostName = "${config.lapbox.hostname}";
    networking.networkmanager.enable = true;
    services.openssh.enable = true;

    users.users."${config.lapbox.username}" = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "nextcloud"
      ];
    };

    lapbox.username = "edward";
    lapbox.groupname = "users";
    lapbox.homedir = "/home/edward";
    lapbox.workspacename = "NixWorkspace";
    lapbox.hostname = "lapbox";
    lapbox.hostdomain = "local";
  };

  # user space options for lapbox
  options = {
    lapbox = {
      username = lib.mkOption {
        type = lib.types.str;
        default = "lapbox";
        example = "lapbox";
        description = lib.mdDoc ''
          Name of lapbox user on the system.
        '';
      };

      groupname = lib.mkOption{
        type = lib.types.str;
        default = "users";
        example = "users";
        description = lib.mdDoc ''
          Name of the lapbox user group on the system.
        '';
      };

      homedir = lib.mkOption {
        type = lib.types.str;
        default = "/home/${options.lapbox.user}";
        example = "/home/lapbox";
        description = lib.mdDoc ''
          Home Directory for the lapbox user.
        '';
      };

      workspacename = lib.mkOption {
        type = lib.types.str;
        default = "NixWorkspace";
        example = "NixWorkspace";
        description = lib.mdDoc ''
          Workspace Directory name in the lapbox homedir.
        '';
      };

      hostname = lib.mkOption {
        type = lib.types.str;
        default = "lapbox";
        example = "lapbox";
        description = lib.mdDoc ''
          Hostname for the system.
        '';
      };

      hostdomain = lib.mkOption {
        type = lib.types.str;
        default = "local";
        example = "local";
        description = lib.mdDoc ''
          Top-Level Domain for the system.
        '';
      };
    };
  };
}
