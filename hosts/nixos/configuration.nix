# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, username, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    optimise.automatic = true;
  };

  boot = {
    # GRUB with os-prober for Windows dual-boot
    loader = {
      systemd-boot.enable = false;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
      efi.canTouchEfiVariables = true;
    };
    # Disable Intel watchdog (fixes slow shutdown)
    kernelParams = [ "nowatchdog" ];
    blacklistedKernelModules = [ "iTCO_wdt" ];
  };

  # Reduce service stop timeout (90s -> 10s)
  systemd.settings.Manager.DefaultTimeoutStopSec = "10s";
  # Also applies to user manager (the "User Manager for UID 1000" on shutdown)
  systemd.user.extraConfig = "DefaultTimeoutStopSec=10s";
  # VSCodium and other electron processes will take too long to stop

  networking = {
    hostName = "codelab-nix";
    networkmanager.enable = true;
  };

  time = {
    timeZone = "Asia/Singapore";
    hardwareClockInLocalTime = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_SG.UTF-8";
      LC_IDENTIFICATION = "en_SG.UTF-8";
      LC_MEASUREMENT = "en_SG.UTF-8";
      LC_MONETARY = "en_SG.UTF-8";
      LC_NAME = "en_SG.UTF-8";
      LC_NUMERIC = "en_SG.UTF-8";
      LC_PAPER = "en_SG.UTF-8";
      LC_TELEPHONE = "en_SG.UTF-8";
      LC_TIME = "en_SG.UTF-8";
    };
  };

  hardware = {
    graphics.enable = true;
    nvidia.open = false;  # allow nonfree nvidia driver
  };

  services = {
    # Enable the X11 windowing system.
    xserver = {
      videoDrivers = [ "nvidia" ];
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    # KDE Plasma Desktop Environment
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = false;
      };
      defaultSession = "plasmax11";
    };
    desktopManager.plasma6.enable = true;

    printing.enable = false;
    pulseaudio.enable = false;
    # Sound with pipewire
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "vboxusers" ];
    shell = pkgs.zsh;
  };

  virtualisation.virtualbox.host.enable = true;

  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  # System-level packages only (user packages managed by home-manager)
  environment.systemPackages = with pkgs; [
    git
    curl
    efibootmgr
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; 
}
