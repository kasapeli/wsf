{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.gsr-ui-nix.nixosModules.default
    ];

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "thinkpad_acpi" "coretemp" ];
  boot.extraModprobeConfig = ''
    options thinkpad_acpi fan_control=1
  '';

  # Graphics
  hardware.graphics = {
  enable = true;
  enable32Bit = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking.hostName = "workstation";
  networking.networkmanager.enable = true;

  # Time Zone
  time.timeZone = "Asia/Phnom_Penh";
  i18n.defaultLocale = "en_US.UTF-8";

  # Display Services
  services.xserver.enable = true;
  programs.sway.enable = true;
  services.displayManager.ly.enable = true;

  # Audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # TLP
  services.power-profiles-daemon.enable = false;
  services.tlp = {
  enable = true;
  settings = {
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave"; # Adjust to your needs

    CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    
    START_CHARGE_THRESH_BAT0 = 75;
    STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };
 
  users.users.yan = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" ];
     packages = with pkgs; [
       tree
       wget
     ];
   };

   services.thermald.enable = true;
   services.throttled.enable = true;

  # Optional
  programs.gpu-screen-recorder = {
    package = inputs.gsr-ui-nix.packages.${pkgs.stdenv.hostPlatform.system}.gpu-screen-recorder;
    enable = true;
    ui.enable = true;
  };
  
 environment.systemPackages = with pkgs; [
   acpi
  ];

  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  # Do not edit
  system.stateVersion = "26.05";

}

