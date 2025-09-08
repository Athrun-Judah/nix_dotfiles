{ inputs, outputs, pkgs, unstablePkgs, ... }:
{
  # import modules
  imports = [
    ../modules/common.nix
    ../modules/wayland/sway.nix
    ../modules/wayland/waybar.nix
    # ../modules/wayland/stylix.nix
    ../modules/programs/fish/fish.nix
    ../modules/programs/ime/ime.nix
    ../modules/programs/helix/helix.nix
    ../modules/programs/mpv/mpv.nix
    ../modules/programs/yazi/yazi.nix
    ../modules/programs/kitty/kitty.nix
    ../modules/languages/dev.nix
    ../modules/fonts/fonts.nix
  ];

  home.username = "player";
  home.homeDirectory = "/home/player";
  home.stateVersion = "25.05";

  home.language.base = "en_US.UTF-8";
  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LANGUAGE = "en_US:zh_CN";
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      # outputs.overlays.additions
      # outputs.overlays.modifications
      # outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    # config = {
    #   # Disable if you don't want unfree packages
    #   allowUnfree = true;
    # };
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;
  # systemd.user.startServices = "sd-switch";
}
