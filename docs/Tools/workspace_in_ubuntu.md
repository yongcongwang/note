# Setup workspace in ubuntu

> environment: ubuntu 18.04

## v2ray
```
bash <(curl -L -s https://install.direct/go.sh)
```

### config
Open the file `/etc/v2ray/config.json` and fill:
```json
{
  "inbound": {
    "port": 1080,
    "listen": "127.0.0.1",
    "protocol": "socks",
    "settings": {
      "auth": "noauth",
      "udp": true
    }
  },
  "outbound": {
    "protocol": "vmess",
    "settings": {
      "vnext": [
        {
          "address": "vps.address",
          "port": 1234,
          "users": [
            {
              "id": "vps.uuid",
              "alterId": 64,
              "level": 1
            }
          ]
        }
      ]
    }
  },
  "outboundDetour": [
    {
      "protocol": "freedom",
      "tag": "direct",
      "settings": {}
    }
  ],
  "routing": {
    "strategy": "rules",
    "settings": {
      "domainStrategy": "IPOnDemand",
      "rules": [
        {
          "type": "field",
          "ip": [
            "0.0.0.0/8",
            "10.0.0.0/8",
            "100.64.0.0/10",
            "127.0.0.0/8",
            "169.254.0.0/16",
            "172.16.0.0/12",
            "192.0.0.0/24",
            "192.0.2.0/24",
            "192.168.0.0/16",
            "198.18.0.0/15",
            "198.51.100.0/24",
            "203.0.113.0/24",
            "::1/128",
            "fc00::/7",
            "fe80::/10"
          ],
          "outboundTag": "direct"
        }
      ]
    }
  }
}
```

### Start the Service

```Bash
systemctl start v2ray
systemctl enable v2ray
```

## Proxychains
needs a working C compiler, preferably gcc

```Bash
git clone git@github.com:rofl0r/proxychains-ng.git &&
./configure --prefix=/usr --sysconfdir=/etc &&
make &&
sudo make install-config
```

### Config
```Bash
sudo echo "sock5 127.0.0.1" >> /etc/proxychains.conf
```

## Chrome

```
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &&
sudo dpkg -i google-chrome-stable_current_amd64.deb
```

### gnome extension
```Bash
sudo apt install gnome-shell-extensions
```
add add the following extensions:
- [coverflow-alt-tab](https://extensions.gnome.org/extension/97/coverflow-alt-tab/)
- [dash-to-panel](https://extensions.gnome.org/extension/1160/dash-to-panel/)
- [hide-top-bar](https://extensions.gnome.org/extension/545/hide-top-bar/)
- [screenshot-tool](https://extensions.gnome.org/extension/1112/screenshot-tool/)
- [sound-output-device-chooser](https://extensions.gnome.org/extension/906/sound-output-device-chooser/)

## git

```
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


## vim

```
sudo apt install vim-gnome
```

### Config
```bash
bash <(curl -s https://raw.githubusercontent.com/yongcongwang/dotfiles/master/deploy.sh) vim
```

## tmux
```
sudo apt install tmux
```

### Config
```
bash <(curl -s https://raw.githubusercontent.com/yongcongwang/dotfiles/master/deploy.sh) tmux
```

## Input Rime
```bash
sudo apt install ibus-rime
```

### config
Modify `$HOME/.config/ibus/rime/default.yaml`:
```yaml
key_binder:
  bindings:
    - { when: always, accept: Control+space, toggle: ascii_mode }
ascii_composer:
  switch_key:
  #  Shift_L: inline_ascii
  #  Shift_R: commit_text
```

Modify `$HOME/.config/ibus/rime/luna_pinyin.schema.yaml`:
```yaml
switches:
  - name: ascii_mode
    reset: 0
    states: [ 西文, 中文 ]
  - name: full_shape
    states: [ 半角, 全角 ]
  - name: simplification
    states: [ 汉字, 漢字 ]
  - name: ascii_punct
    states: [ 。，, ．， ]
```

## Translate Shell
```bash
sudo apt install translate-shell
```
