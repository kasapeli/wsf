{ config, pkgs, ... }:

{
  home.username = "yan";
  home.homeDirectory = "/home/yan";

  home.stateVersion = "26.05"; 

  home.packages = with pkgs; [
    git
    helix
    firefox
    htop
  ];

  programs.home-manager.enable = true;
}

