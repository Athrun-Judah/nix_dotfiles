# 我的 Fedora Sway 桌面环境搭建手册

## 第一步：准备 Fedora 基础系统

在一台新安装的 Fedora Workstation 系统上，执行以下命令来安装和配置核心的系统级服务和驱动。

### 1. 安装虚拟化支持 (QEMU/KVM)
sudo dnf groupinstall --with-optional "Virtualization"
sudo systemctl enable --now libvirtd
# 将 'player' 替换为你的用户名
sudo usermod -aG libvirt player

### 2. 安装 NVIDIA 闭源驱动
# 遵循 Fedora 官方或社区的最佳实践指南
# 例如：https://www.if-not-true-then-false.com/2015/fedora-nvidia-guide/

### 3. 安装需要特殊权限的工具 (Wireshark)
sudo dnf install wireshark
# 将 'player' 替换为你的用户名
sudo usermod -aG wireshark player

### 4. (可选) 安装 VirtualBox
sudo dnf install VirtualBox kernel-devel
sudo /sbin/vboxconfig
# 将 'player' 替换为你的用户名
sudo usermod -aG vboxusers player

# 完成以上步骤后，请务必注销并重新登录，以使用户组权限生效。

## 第二步：部署声明式用户环境

### 1. 安装 Nix 包管理器
sh <(curl -L https://nixos.org/nix/install) --daemon

### 2. 启用 Flakes 功能
sudo mkdir -p /etc/nix
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf

### 3. 克隆本配置仓库
# 将 <your-repo-url> 替换为您自己的仓库地址
git clone <your-repo-url> ~/nix-config

### 4. 应用 Home Manager 配置
cd ~/nix-config
home-manager switch --flake .#player@fedora

### 5. 最终完成
注销并重新登录系统，享受你的完美桌面！
