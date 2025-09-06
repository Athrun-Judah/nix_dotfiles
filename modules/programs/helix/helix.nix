# ~/nix-config/modules/home-manager/helix.nix
#
# 这是一个专门用于配置 Helix 编辑器的模块。
#
{ pkgs, ... }:

{
  # 1. 安装 Helix 软件包
  home.packages = with pkgs; [
    helix
  ];

  # 2. 设置默认编辑器环境变量
  # 这是让整个系统知道默认使用 Helix 的关键
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx"; # VISUAL 通常用于图形界面程序，保持一致是个好习惯
  };

  # 3. 声明式地管理 Helix 的配置文件
  home.file = {
    ".config/helix" = {
      source = ../../../config/helix;
      recursive = true;
    };
      };
}
