{ pkgs, ... }: {
  home.packages = with pkgs; [
    brightnessctl
    wdisplays
    jq # 上面的截图功能需要 jq
    blueman # 蓝牙管理器
    nwg-look # GTK 主题、图标、字体设置
    networkmanagerapplet # 网络管理器Applet (提供 nm-connection-editor)
    pavucontrol # 音频脉冲控制
    gammastep # 夜间模式
    xfce.thunar # Files manager
    xfce.thunar-volman # 自动挂载U盘
    xfce.thunar-archive-plugin # 压缩文件支持
    xfce.thunar-media-tags-plugin
    xfce.thunar-vcs-plugin
    git
    htop
    btop
    unzip
    fzf
    fd
    ripgrep
    grc
    ffmpegthumbnailer
    poppler_utils
    fontpreview
    imv
    zathura
    nwg-look
    zoxide
    tree
    libreoffice-fresh
    hunspell
    hunspellDicts.en_US
    librewolf
    brave
    virt-manager
    telegram-desktop
    signal-desktop
    obsidian
    thunderbird
    calibre
    obs-studio
    anki
    zed-editor
    steam
    heroic
    qalculate-gtk
    morgen        # calendar
    gsimplecal
  ];

  # 启用蓝牙 Applet 服务
  services.blueman-applet.enable = true;
  services.gammastep = {
    enable = true;
    provider = "geoclue2"; # 自动获取地理位置
  };
}
