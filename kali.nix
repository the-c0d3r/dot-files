{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Pentesting tools from install-kali.sh
    enum4linux
    feroxbuster
    nbtscan
    nikto
    onesixtyone
    # oscanner # Might not be in nixpkgs, commenting out for safety
    smbmap
    smtp-user-enum
    net-snmp # provides snmp tools
    sslscan
    sipvicious
    # tnscmd10g # Might not be in nixpkgs
    whatweb
    wkhtmltopdf
    samba # provides smbclient
    
    python3
    python3Packages.pip
  ];
}
