{ pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    extraConfig = builtins.readFile ../../config/sway/config;
  };

  home.packages = with pkgs; [
    swaylock-effects # 锁屏
    swayidle         # 空闲管理守护进程
    swaybg           # Sway 壁纸工具
    waybar           # 状态栏
    wofi             # 应用启动器
    mako             # 通知守护进程
    wl-clipboard     # Wayland 剪贴板工具
    grim             # 截图
    slurp            # 屏幕区域选择
    wf-recorder
    (writeShellScriptBin "lock-screen" (builtins.readFile ../../config/scripts/lock.sh))
  ];
}
