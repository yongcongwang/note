# Setup Workspace in Linux

## Keyboard

Set caps to control

```Bash
setxkbmap -layout us -option ctrl:nocaps
```

## Git

```Bash
sudo apt install git
# config
git config --global user.name "YongcongWang"
git config --global user.email "yongcong.wang@outlook.com"
git config --global core.editor vim
# generate key
ssh-keygen -t rsa -C "yongcong.wang@outlook.com"
```

### Config

1. Open [github](https://github.com/) and sign in;
2. In `Settings/SSH and GPG keys` click `New SSH Key`;
3. Paste `id_rsa.PUB`(in `/home/.ssh/id_rsa.pub`);
4. Test: `ssh -T git@github.com`.

## Vim

### Install

```
git clone git@github.com:vim/vim.git &&
cd vim && make && sudo make install
```

### Config

```Bash
git clone git@github.com:yongcongwang/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && bash deploy.sh vim
```

## Translater

```Bash
sudo apt install translate-shell
```

## Terminal

```Bash
sudo apt install guake
```
