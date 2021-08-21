#!/bin/bash

# Neovim, tmux
sudo apt install -y python3-pip python-dev python3-dev neovim tmux

# Autorecon dependencies
sudo apt install -y curl enum4linux feroxbuster nbtscan nikto nmap onesixtyone oscanner smbclient smbmap smtp-user-enum snmp sslscan sipvicious tnscmd10g whatweb wkhtmltopdf

# Autorecon
sudo python3 -m pip install git+https://github.com/Tib3rius/AutoRecon.git

