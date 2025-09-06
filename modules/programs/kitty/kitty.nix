{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true; # 再次声明 enable，确保 kitty 包被安装

    # 使用 extraConfig 来追加配置到 stylix 生成的文件之后
    # 这样我们的功能配置就不会覆盖 stylix 的主题配置
    extraConfig = ''
      # --- 字体 ---
      # 我们在这里再次明确字体，确保它覆盖任何可能的默认值
      # 这会使用我们在 stylix 中定义的全局等宽字体
      font_family      ${config.stylix.fonts.monospace.name}
      bold_font        auto
      italic_font      auto
      bold_italic_font auto
      font_size 12.0

      # --- Shell 集成 ---
      # 这是一个强大的功能，能让终端和 Shell 更好地协作
      # 比如，能够在终端中跳到上一个命令的输出位置
      shell_integration enabled

      # --- 界面与体验 ---
      # 窗口边距
      window_padding_width 10
      # 背景透明度 (如果 stylix 中已设置，这里会覆盖)
      background_opacity 0.8
      # 光标样式
      cursor_shape block
      # 当光标停止输入时闪烁
      cursor_blink_interval -1
      # 滚动回溯行数
      scrollback_lines 2000

      # --- 按键绑定 (使用现代语法) ---
      # 清屏
      map ctrl+shift+l clear_terminal scrollback_and_prompt

      # 复制/粘贴
      map ctrl+shift+c copy_to_clipboard
      map ctrl+shift+v paste_from_clipboard

      # 字体大小
      map ctrl+shift+equal  change_font_size all +1.0
      map ctrl+shift+minus change_font_size all -1.0
      map ctrl+shift+0    change_font_size all 0

      # 新建窗口/标签/分屏
      map ctrl+shift+enter launch --type=window --cwd=current
      map ctrl+shift+t     launch --type=tab --cwd=current
      map ctrl+shift+o     launch --type=overlay --cwd=current

      # 分屏导航
      map ctrl+shift+j next_window
      map ctrl+shift+k previous_window

      # 标签导航
      map ctrl+shift+right next_tab
      map ctrl+shift+left  previous_tab

      # 滚动
      map ctrl+shift+up    scroll_line_up
      map ctrl+shift+down  scroll_line_down
      map ctrl+shift+page_up   scroll_page_up
      map ctrl+shift+page_down scroll_page_down
    '';
  };
}
