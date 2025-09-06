{ pkgs, ... }:
{
  # 1. 使用新的包名来安装字体
  home.packages = with pkgs; [
    nerd-fonts.atkynson-mono
    nerd-fonts.symbols-only

    source-han-sans
    source-han-serif
  ];

  # 2. Fontconfig 的配置保持不变，它只关心字体名
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [
        "AtkynsonMono Nerd Font"
        "Source Han Serif CN"
        "Symbols Nerd Font Mono"
      ];
      sansSerif = [
        "AtkynsonMono Nerd Font"
        "Source Han Sans CN"
        "Symbols Nerd Font Mono"
      ];
      monospace = [
        "AtkynsonMono Nerd Font Mono"
        "Source Han Sans CN"
        "Symbols Nerd Font Mono"
      ];
    };
  };
}
