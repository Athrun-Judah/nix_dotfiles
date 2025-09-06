{ pkgs, config, inputs, ... }:

{
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    enable = true;
    image = ../../assets/Sakura.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    # --- 全局配置 (Top-level) ---

    # 1. 光標配置 (正確路徑: stylix.cursor)
    cursor = {
      package = pkgs.catppuccin-cursors.mochaDark;
      name = "Catppuccin-Mocha-Dark";
      size = 24;
    };

    # 2. 字體配置 (正確路徑: stylix.font，注意不是 fonts)
    fonts = {
      serif = {
        # 使用新的包名
        package = pkgs.nerd-fonts.atkynson-mono;
        name = "AtkynsonMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.atkynson-mono;
        name = "AtkynsonMono Nerd Font";
      };
      monospace = {
        package = pkgs.nerd-fonts.atkynson-mono;
        name = "AtkynsonMono Nerd Font Mono";
      };
      sizes = { applications = 11; desktop = 11; terminal = 12; popups = 11; };
    };

    targets = {
      gtk.enable = true;
    };

  };
}
