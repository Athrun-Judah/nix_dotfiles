{ pkgs, ... }:

{
  # 启用 Waybar 程序
  programs.waybar.enable = true;

  # ------------------------------------------------------------------
  # Waybar 的设置 (最终会生成 ~/.config/waybar/config 文件)
  # ------------------------------------------------------------------
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 35;
      # 在左、中、右区域分别显示哪些模块
      modules-left = [ "sway/workspaces" "sway/mode" ];
      modules-center = [ "sway/window" ];
      modules-right = [ "pulseaudio" "network" "cpu" "memory" "clock" "tray" ];

      # 各个模块的具体配置
      "sway/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
        format = "{name}";
      };
      "pulseaudio" = {
        format = "{volume}% {icon}";
        format-muted = " Muted";
        format-icons = {
          headphone = "🎧";
          hands-free = "🎧";
          headset = "🎧";
          phone = "";
          portable = "";
          car = "";
          default = ["" "" ""];
        };
        on-click = "pavucontrol"; # 点击打开音量控制
      };
      "network" = {
        format-wifi = "{essid} ({signalStrength}%) ";
        format-ethernet = "{ifname} ";
        format-disconnected = "Disconnected ⚠";
        on-click = "nm-connection-editor"; # 点击打开网络连接编辑器
      };
      "cpu" = {
        format = "{usage}% ";
        tooltip = true;
      };
      "memory" = {
        format = "{}% ";
      };
      "clock" = {
        format = "{:%H:%M  %Y-%m-%d}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };
      "tray" = {
        icon-size = 21;
        spacing = 10;
      };
    };
  };

  # ------------------------------------------------------------------
  # Waybar 的样式 (最终会生成 ~/.config/waybar/style.css 文件)
  # ------------------------------------------------------------------
  programs.waybar.style = ''
    /* 导入字体 */
    @import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;700&display=swap');

    * {
        border: none;
        border-radius: 0;
        // font-family: "JetBrains Mono Nerd Font", "JetBrains Mono", sans-serif;
        font-size: 14px;
        min-height: 0;
    }

    window#waybar {
        background: rgba(30, 30, 45, 0.85); /* 半透明深蓝灰色背景 */
        border-bottom: 2px solid #cba6f7; /* 淡紫色底部边框 */
        color: #cdd6f4; /* 默认文字颜色 */
    }

    /* 各个模块的通用样式 */
    #workspaces,
    #mode,
    #clock,
    #pulseaudio,
    #network,
    #cpu,
    #memory,
    #tray,
    #window {
        padding: 0 10px;
        margin: 0 4px;
    }

    /* 工作区按钮 */
    #workspaces button {
        padding: 0 5px;
        background: transparent;
        color: #cdd6f4;
        border-bottom: 2px solid transparent;
    }

    #workspaces button.visible {
        color: #f5c2e7; /* 可见但未聚焦的工作区 */
    }

    #workspaces button.focused {
        color: #cba6f7; /* 当前聚焦的工作区 */
        border-bottom: 2px solid #cba6f7;
    }

    #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        background: #cba6f7;
        color: #1e1e2e;
    }

    /* 关键模块的颜色 */
    #pulseaudio {
        color: #89b4fa;
    }
    #network {
        color: #a6e3a1;
    }
    #cpu {
        color: #f38ba8;
    }
    #memory {
        color: #f9e2af;
    }
    #clock {
        color: #fab387;
    }

    /* 状态指示颜色 */
    #network.disconnected {
        color: #f38ba8;
    }
    #pulseaudio.muted {
        color: #9399b2;
    }
  '';

  # 确保 Waybar 需要的字体和工具已经安装
  home.packages = with pkgs; [
    # (nerdfonts.override { fonts = [ "AtkynsonMono NF" ]; }) # 安装带图标的 Nerd Font
    pavucontrol       # 音量控制 GUI
    networkmanagerapplet # 网络连接编辑器
  ];
}
