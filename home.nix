{ config, pkgs, ... }:

{
  home.username = "yan";
  home.homeDirectory = "/home/yan";

  home.stateVersion = "26.05"; 

  home.packages = with pkgs; [
    # Sway
    fastfetch
    waybar
    swaylock
    mako
    rofi
    awww
    swayidle    
    sway-contrib.grimshot
    wl-clipboard

    # CLI
    git
    helix
    tree
    htop
    fish
    brightnessctl

    # Misc
    firefox
    vesktop
    kdePackages.dolphin

    # Fonts  
    nerd-fonts.jetbrains-mono
    noto-fonts
    twitter-color-emoji
 ];

 fonts.fontconfig = {
   enable = true;
   defaultFonts.emoji = [ "Twitter Color Emoji" "Twemoji Mozilla" ];
 };


  xdg.configFile."sway/config".source = ./config/sway/config;
  xdg.configFile."fish/config.fish".source = ./config/fish/config.fish;
  xdg.configFile."waybar/config.jsonc".source = ./config/waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source = ./config/waybar/style.css;

  programs.home-manager.enable = true;
}

