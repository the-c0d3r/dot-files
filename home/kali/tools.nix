# home/kali/tools.nix — Pentest tools
#
# Add/remove tools here without touching anything else.

{ pkgs, ... }:

let
  htbScripts = builtins.fetchGit {
    url = "https://github.com/the-c0d3r/htb-scripts";
    rev = "b44aa149c31d6d9ddc67120714429beb3a922d49";
  };
in
{
  home.sessionPath = [ "${htbScripts}" ];

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
  ];
}
