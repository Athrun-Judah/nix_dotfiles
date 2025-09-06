{ pkgs, inputs, ... }:

{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true; # 保留对 Fish 的深度集成

    # 以 Wiki 的全面配置为基础
    settings = {
      manager = {
        # 窗口比例 [左, 中, 右]
        ratio = [ 1 4 3 ];
        # 排序方式：自然排序 (e.g., "2.txt" < "10.txt")
        sort_by = "natural";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        # 显示隐藏文件
        show_hidden = true;
        show_symlink = true;
      };

      preview = {
        image_filter = "lanczos3";
        image_quality = 90;
        tab_size = 2; # 我把它从1改成了2，更符合常规
        max_width = 600;
        max_height = 900;
      };

      tasks = {
        micro_workers = 5;
        macro_workers = 10;
        bizarre_retry = 5;
      };

      # 融入我们自己的 opener 配置，确保 Helix 是默认编辑器
      opener = {
        edit = [
          { run = ''hx "$@"''; block = true; desc = "Edit files with Helix"; }
        ];
      };
    };
  };

  home.file = {
    # 我们现在从 yazi-plugins 这个统一输入的子目录来链接插件
    ".config/yazi/plugins/fzf.yazi".source = "${inputs.yazi-plugins}/fzf.yazi";
    ".config/yazi/plugins/archive.yazi".source = "${inputs.yazi-plugins}/archive.yazi";
    ".config/yazi/plugins/zoxide.yazi".source = "${inputs.yazi-plugins}/zoxide.yazi";

    # 部署按键绑定文件
    # ".config/yazi/keymap.toml".source = "../../config/yazi/keymap.toml";
  };
}
