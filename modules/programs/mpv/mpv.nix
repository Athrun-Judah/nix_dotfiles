{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mpv-shim-default-shaders
  ];
  # 1. 启用 MPV 并进行配置
  programs.mpv = {
    enable = true;

    # MPV 的配置文件 (~/.config/mpv/mpv.conf)
    # 我们在这里直接用 Nix 语法进行配置
    config = {
      # --- 视频 ---
      vo = "gpu";             # 使用 GPU 进行视频输出，性能最佳
      hwdec = "auto-safe";    # 自动尝试安全的硬件解码，降低 CPU 占用
      profile = "gpu-hq";     # 使用高质量的着色器预设
      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";

      # --- 音频 ---
      volume = 80;            # 默认音量为 80%
      volume-max = 150;       # 允许的最大音量（超100%需要谨慎）

      # --- 界面 (OSC - On Screen Controller) ---
      osc = "yes";            # 启用现代化的屏幕控制器（播放进度条、按钮等）
      border = "no";          # 播放时隐藏窗口边框

      # --- 其他行为 ---
      save-position-on-quit = "yes"; # 退出时保存播放进度
      keep-open = "yes";             # 播放结束后不自动关闭窗口
      autofit-larger = "90%x90%";   # 自动缩放过大的视频以适应屏幕

      # --- 截图 ---
      screenshot-format = "png";
      screenshot-png-compression = 8;
      screenshot-directory = "~/Pictures/Screenshots/MPV"; # 设置截图保存目录

      # 这是一个高质量的着色器组合，适用于大多数现代 GPU
      # FSRCNNX 用于高质量的动漫/卡通拉伸
      # KrigBilateral 用于通用锐化
      # ssim annd dscale are for high quality downscaling.
      glsl-shaders = [
        "~~/shaders/FSRCNNX_x2_16-0-4-1.glsl"
        "~~/shaders/KrigBilateral.glsl"
        "~~/shaders/ssim.glsl"
        "~~/shaders/dscale.glsl"
      ];
    };

    # MPV 的按键绑定文件 (~/.config/mpv/input.conf)
    # 你可以在这里覆盖或添加自定义快捷键
    bindings = {
      "s" = "screenshot";
      "S" = "screenshot video";
      "Ctrl+s" = "screenshot window";
      # 新增：打开播放列表和文件浏览器
      "p" = "script-binding playlistmanager";
    };

    # MPV 脚本管理
    # Nix Home Manager 可以非常方便地管理 mpv 脚本
    scripts = with pkgs.mpvScripts; [
      # uosc 是一个更美观、更强大的 OSC (On-Screen Controller) 界面
      uosc
      mpv-playlistmanager
    ];

    scriptOpts.uosc = {
      # 主题风格：bar (现代长条形), line (细线), fat (粗线)
      timeline_style = "bar";
      # 颜色主题：dark, light, auto
      theme = "dark";
      # 字体，保持和你的系统一致
      # font = "AtkynsonMono NF";
      # 进度条颜色，可以设置成你喜欢的主题色
      seekbar_color = "9370db"; # 例如，Catppuccin Green
      # 控制元素的可见性
      visibility = "auto"; # auto, always, never
    };
  };
}
