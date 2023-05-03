{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Other packages...
  ];

  # Enable the OpenSSH daemon
  services.openssh.enable = true;

  # Configure NixOS to automatically attach users to existing Tmux sessions or create new ones
  #services.openssh.extraConfig = ''
  #  ForceCommand /etc/nixos/ssh/tmux_ssh.sh
  #'';

  environment.shellAliases = {
    attach = "/home/edward/NixWorkspace/System/tmux_attach.sh";
   };

  # Enable mosh. Opens UDP ports 60000 ... 61000
  programs.mosh.enable = true;

  programs.tmux = {
    enable = true;
    clock24 = true;
    plugins = with pkgs;
    [
        tmuxPlugins.power-theme
        tmuxPlugins.resurrect
        tmuxPlugins.continuum
    ];
    extraConfig = '' # Writes directly to /etc/tmux.conf
      set -g @tmux_power_theme 'coral'
      set -g @continuum-restore 'on'

      set -g @tmux_power_date_icon '🗓️' # set it to a blank will disable the icon
      set -g @tmux_power_time_icon '⌚️' # emoji can be used if your terminal supports
      set -g @tmux_power_user_icon '👤'
      set -g @tmux_power_session_icon '🔏'
      set -g @tmux_power_upload_speed_icon '⬆'
      set -g @tmux_power_download_speed_icon '⬇'
      set -g @tmux_power_left_arrow_icon '←'
      set -g @tmux_power_right_arrow_icon '→'
  '';
  };
}

