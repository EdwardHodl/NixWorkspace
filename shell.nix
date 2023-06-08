{ pkgs ? import <nixpkgs> {} }:

let
  local = "~/NixWorkspace";

  remoteuser = "edward";
  remotehost = "lapbox.local";
  remotepath = "/home/${remoteuser}/";
in
pkgs.mkShell {

  shellHook =
  ''
    echo "In NixWorkspace development shell."
    alias syncws="rsync -avm --include='*.nix' --include='*/' --exclude='*' ${local} ${remoteuser}@${remotehost}:${remotepath}"
    alias
  '';
}
