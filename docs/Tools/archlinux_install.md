# Archlinux Installation

## Before Start

### BIOS

- Disable `Secure Boot`
- Boot Mode `UEFI` Only

## Basic Install

### Disable reflector

```
systemctl stop reflector.service
```

### Check `UEFI` Mode

Outputs after command below:

```
ls /sys/firmware/efi/efivars
```

### Connect Network

```
iwctl
device list
station wlan0 scan
station wlan0 get-networks
station wlan0 connect ${WIFI}
```

### Update Clock

```
timedatectl set-ntp true
timedatectl status
```

### Partition

```
lsblk
parted /dev/nvme0n1
New disk lable type? gpt
quit
```

Divide hard disk to three parts with `cfdisk /dev/nvme0n1`:

- `/efi`: `EFI System`, 800M
- `/`: `Linux filesystem`, 100G
- `/home`: `Linux filesystem`, other

Check with `fdisk -l`

### Format

```
mkfs.vfat /dev/nvme0n1p1
mkfs.ext4 /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p3
```

### Mount

```
mount /dev/nvme0n1p2 /mnt

mkdir /mnt/efi
mount /dev/nvme0n1p1 /mnt/efi

mkdir /mnt/home
mount /dev/nvme0n1p3 /mnt/home
```

### Select Server

```
vim /etc/pacman.d/mirrorlist
```

Add following lines at begining:

```
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
```

### Install System

```
pacstrap /mnt base base-devel linux linux-headers linux-firmware
```

```
pacstrap /mnt dhcpcd iwd vim bash-completion
```

### Generate `fstab` file

```
genfstab -U /mnt >> /mnt/etc/fstab
```

Check with:

```
cat /mnt/etc/fstab
```

### Change Root

```
arch-chroot /mnt
```

### Set Timezone

```
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
```

Hardware sync:

```
hwclock --systohc
```

### Set Locale

Uncomment:

- en_US.UTF-8
- zh_CN.UTF-8

in `/etc/locale.gen`, and generate with:

```
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
```

### Set Host

```
echo 'arch' > /etc/hostname
```

Add following to `/etc/hosts`:

```
127.0.0.1 localhost
::1       localhost
127.0.1.1 arch
```

### Change Root Password

```
passwd root
```

### Install Micro-Code

```
pacman -S intel-ucode  ## for intel
pacman -S amd-ucode    ## for amd
```

### Install Grub

```
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
```

Change the line in `/etc/default/grub` to:

```
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=5 nowatchdog"
```

And generate with

```
grub-mkconfig -o /boot/grub/grub.cfg
```

### Finish

```
exit
umount -R /mnt
reboot
```

And after restarting, start the service `systemctl start dhcpcd` to connect to the internet.

## Desktop Install

### Update System

```
pacman -Syyu
```

### Add Non-root User

```
useradd -m -G wheel -s /bin/bash wyc
passwd wyc
```

Add sudo priority:

```
EDITOR=vim visudo
```

and umcomment following line:

```
#%wheel ALL=(ALL:ALL) ALL
```

### Support 32-bit Library

```
vim /etc/pacman.conf
```

and uncomment:

```
[multilib]
Include = /etc/pacman.d/mirrorlist
```

### Install Software

- xterm
- openssh
- translate-shell
- feh
- rofi
- ranger
- neofetch
- htop
- gdb
- flameshot
- vlc
- arandr
- yay: `git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si`
- google-chrome
- ttf-hack
- wqy-microhei


### Install i3

```
pacman -S i3-wm xorg-xinit xorg-server
cp /etc/X11/xinit/xinitrc ~/.xinitrc
echo startx >> ~/.bashrc
```

and change the tail of `~/.xinitrc` to:

```
exec i3
```

and add following lines to `~/.bash_profile`

```
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
```

### Setup git

```Bash
sudo apt install git
# config
git config --global user.name "YongcongWang"
git config --global user.email "yongcong.wang@outlook.com"
git config --global core.editor vim
# generate key
ssh-keygen -t rsa -C "yongcong.wang@outlook.com"
```

Config:

1. Open [github](https://github.com/) and sign in;
2. In `Settings/SSH and GPG keys` click `New SSH Key`;
3. Paste `id_rsa.PUB`(in `/home/.ssh/id_rsa.pub`);
4. Test: `ssh -T git@github.com`.

```Bash
git clone git@github.com:yongcongwang/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && bash deploy.sh git
```

### Install Chinese Input

```
sudo pacman -S fcitx5 fcitx5-qt fcitx5-config-qt fcitxt-rime rime-luna-pinyin
```

add following lines to `/etc/environment`:

```
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
```
