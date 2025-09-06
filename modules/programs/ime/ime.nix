#
# 这是一个专门用于配置 Fcitx5 和 Rime 输入法的模块。
#
{ config, pkgs, inputs, ... }:
let
  rimeDir = ".local/share/fcitx5/rime";
in
{
  # 1. 启用 Fcitx5 服务
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-chinese-addons
      fcitx5-configtool
      fcitx5-gtk
    ];
  };
  # services.fcitx5 = {
  #   enable = true;
  #   addons = with pkgs; [
  #     fcitx5-rime
  #     fcitx5-chinese-addons
  #     fcitx5-configtool
  #     fcitx5-gtk
  #   ];
  # };

  # 2. 设置必要的环境变量
  home.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    GLFW_IM_MODULE = "ibus";
  };

  # 3. 部署 Rime 配置文件
  # Rime 的用户配置放在 ~/.local/share/fcitx5/rime/
  home.file = {
    # 3.1 部署“雾凇拼音”配置集 (保持不变)
    "${rimeDir}/rime-ice".source = inputs.rime-ice.outPath;

    # 3.2 部署我们自己的 Rime 配置文件
    # Home Manager 会将 ../../config/rime 目录下的所有文件
    # 递归地复制到 ~/.local/share/fcitx5/rime/ 目录下
    "${rimeDir}/" = {
      source = ../../../config/rime; # <-- 路径相对于当前 .nix 文件
      recursive = true; # 确保是递归复制
    };
  };
}
