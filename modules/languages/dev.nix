{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Rust ---
    # rust-toolchain 会包含 rustc, cargo, clippy, rustfmt 等核心工具
    (rust-bin.fromRustupToolchainFile ./rust-toolchain.toml)

    # --- C/C++ ---
    # gcc 是 GNU 编译器套装，gdb 是调试器
    gcc
    gdb
    # clang 和 lldb 是 LLVM/Clang 工具链 (clang 已在 helix.nix 中安装)
    # cmake 和 gnumake 是最常用的构建工具
    cmake
    gnumake

    # --- Python ---
    # python3Full 包含了 pip, venv 等常用工具
    python3Full
    uv

    # --- Perl ---
    # perl 和 cpanm (Perl 的包管理器)
    perl
    perl538Packages.CPANPLUS

    # --- JavaScript / TypeScript ---
    # 安装 Node.js (推荐 LTS 版本) 和核心包管理器
    # 使用fnm
    fnm
    # nodejs_24 # 或者其他你需要的版本
    # npm 已经随 nodejs 安装
    pnpm
  ];
}
