#
# 这是一个专门用于配置 Fish Shell 和 Starship 主题的模块。
#
{ config, pkgs, ... }:

{
  # 1. 启用 Fish Shell 并设为默认
  programs.fish = {
    enable = true;
    # Fish 的交互式配置，你可以在这里添加函数、别名等
    interactiveShellInit = ''
      set -g fish_greeting # 禁用欢迎语
      # 你可以在这里设置环境变量，例如
      # set -x EDITOR "hx"
    '';

    # Fish 插件管理
    plugins = [
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "z";
        src = pkgs.fishPlugins.z.src;
      }
      {
        name = "puffer";
        src = pkgs.fishPlugins.puffer.src;
      }
      {
        name = "bass";
        src = pkgs.fishPlugins.bass.src;
      }
    ];
  };

  # 2. 将 fish 设置为当前用户的默认 Shell
  # users.defaultUserShell = pkgs.fish;

  # 3. 启用 Starship 主题
  # Home Manager 会自动为 Fish, Bash, Zsh 等配置好 Starship
  programs.starship = {
    enable = true;
    # Starship 的配置文件 (~/.config/starship.toml)
    # 我们在这里直接用 Nix 语法进行配置
    settings = {
      # 在输入命令前添加一个新行，让界面更清爽
      add_newline = true;

      # 格式化各个模块
      format = ''
        [](#9A95F9)\
        $os\
        $username\
        [](bg:#DA627D fg:#9A95F9)\
        $directory\
        [](bg:#FCA17D fg:#DA627D)\
        $git_branch\
        $git_status\
        [](bg:#86BBD8 fg:#FCA17D)\
        $c\
        $golang\
        $rust\
        $nix_shell\
        [](bg:#06969A fg:#86BBD8)\
        $docker_context\
        [](bg:#33658A fg:#06969A)\
        $time\
        [ ](fg:#33658A)\
        $line_break\
        $character
      '';

      # 各个模块的具体配置
      directory = {
        style = "bg:#DA627D";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };
      directory.substitutions = {
        "Documents" = "󰈙 ";
        "Downloads" = " ";
        "Music" = " ";
        "Pictures" = " ";
        "nix-config" = "❄️ ";
      };

      git_branch = {
        symbol = "";
        style = "bg:#FCA17D";
        format = "[ $symbol $branch ]($style)";
      };
      git_status = {
        style = "bg:#FCA17D";
        format = "[($all_status$ahead_behind )]($style)";
      };

      # ... 你可以在这里添加更多语言或工具的模块 ...
      nix_shell = {
        symbol = "❄️";
        style = "bg:#86BBD8";
        format = "[ $symbol $state( $name) ]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:#33658A";
        format = "[  $time ]($style)";
      };

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };

  # 4. 确保 Fish 需要的工具已安装
  home.packages = with pkgs; [
    fzf # fzf 模糊搜索工具，被 fzf-fish 插件使用
    # bat # (可选) 推荐一个带语法高亮的 cat 替代品
  ];

  # config
  home.file = {
    ".config/fish/conf.d" = {
      source = ../../../config/fish;
      recursive = true;
    };
  };
}
