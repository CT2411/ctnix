{ pkgs, ... }:
let
  choco = pkgs.writeShellApplication {
    name = "choco";
    text = ''
      cmd=''${1:-help}
      [ $# -gt 0 ] && shift

      case "$cmd" in
        install | add)
          for pkg in "$@"; do
            NIXPKGS_ALLOW_UNFREE=1 nix profile add --impure "nixpkgs#$pkg"
          done
          ;;
        uninstall | remove)
          for pkg in "$@"; do
            nix profile remove "$pkg"
          done
          ;;
        search | find)
          nix search nixpkgs "$@"
          ;;
        list)
          nix profile list
          ;;
        upgrade | update)
          nix profile upgrade --all
          ;;
        *)
          echo "Benutzung: choco install|uninstall|search|list|upgrade [Paket ...]"
          echo "Pakete kommen aus nixpkgs (https://search.nixos.org/packages)."
          ;;
      esac
    '';
  };
in
{
  home.packages = [ choco ];
}
