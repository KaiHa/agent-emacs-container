# /etc/nixos/configuration.nix
#
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  vibe = (builtins.getFlake "github:/mistralai/mistral-vibe/main").packages.x86_64-linux.default;
  emacs-custom = (pkgs.emacs-pgtk.pkgs.withPackages (p: [
    p.avy
    p.ess
    p.iedit
    p.magit
    p.nix-mode
    p.treesit-grammars.with-all-grammars
  ]));
in {
  imports = [];

  boot.isNspawnContainer = true;
  boot.loader.initScript.enable = true;
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = false;

  console.enable = true;

  fonts.packages = with pkgs; [
    dejavu_fonts
    font-awesome
    ibm-plex
    inconsolata
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  networking.hostName = "";
  networking.useDHCP = false;
  networking.useNetworkd = true;
  networking.useHostResolvConf = false;
  networking.firewall.enable = false;

  nix.settings.sandbox = false;

  # services.sshd.enable = true;

  system.stateVersion = "25.11";

  time.timeZone = "Europe/Amsterdam";

  users.mutableUsers = false;
  users.users.root.password = "nosecret";
  users.users.kai = {
    isNormalUser = true;
    uid = 1000;
    initialPassword = "nosecret";
    extraGroups = [
      # "wheel"
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    emacs-custom
    gnumake
    universal-ctags
    vibe
  ];
}
