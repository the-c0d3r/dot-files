# home/kali.nix — Kali Linux-specific home-manager config
#
# Adds pentesting tools on top of the generic Linux config.
# Applied via: homeConfigurations."kali" in flake.nix
# (which also imports home/linux.nix → home/default.nix)

{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Network enumeration
    enum4linux
    nbtscan
    onesixtyone
    smbmap
    net-snmp        # provides snmpwalk, snmpget, etc.

    # Web
    feroxbuster
    nikto
    whatweb
    wkhtmltopdf

    # Protocols
    smtp-user-enum
    sslscan
    sipvicious
    samba           # provides smbclient

    # Scripting
    python3
    python3Packages.pip
  ];
}
