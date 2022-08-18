# My nixos configuration files

## Useful links

* [NixOS Wiki](https://nixos.wiki/wiki/Main_Page)
* [home-manager](https://github.com/nix-community/home-manager)
* [nix community's github](https://github.com/nix-community)
* [nixos documentation](https://nixos.org/learn.html)
* [nix package search engine](https://search.nixos.org/packages)

## Initial install

```bash
# set keyboard layout
loadkeys fr

# set larger font if screen is 4K
setfont ter-v32n

# start wpa_supplicant if wifi is needed
systemctl start wpa_supplicant.service

# connect to wifi
wpa_cli <<EOF
add_network
set_network 0 ssid "$SSID"
set_network 0 psk "$PASSWORD"
set_network 0 key_mgmt WPA-PSK
enable_network 0
EOF

# disk partitioning (create 2 partitions)
# > /dev/sdx1 | start 2048   | end +512MB | EFI System
# > /dev/sdx2 | start +512MB | end 100%   | Linux LVM
fdisk /dev/sdx
# TODO : see how to do commands with parted

# create a luks volume
cryptsetup luksFormat /dev/sdx2

# open the luks volume called "cryptlvm"
cryptsetup open /dev/sdx2 cryptlvm

# create an lvm physical volume
pvcreate /dev/mapper/cryptlvm

# create a volume group
vgcreate main /dev/mapper/cryptlvm

# create lvm volumes
lvcreate -L 10G main -n root
lvcreate -L 10G main -n home
lvcreate -L 2G main -n swap

# format volumes 
mkfs.ext4 -L root /dev/main/root
mkfs.ext4 -L home /dev/main/home
mkswap -L swap /dev/main/swap
mkfs.fat -F 32 -n boot /dev/main/sdx1

# mount filesystem
mount /dev/disk/by-label/root /mnt
mkdir /mnt/home
mount /dev/disk/by-label/home /mnt/home
mkdir /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/disk/by-label/swap

# generate nixos /etc/ structure
nixos-generate-config --root /mnt
curl -o /mnt/etc/nixos/hardware-configuration.nix https://raw.githubusercontent.com/0b11stan/nixconfig/main/system/hardware-configuration.nix
curl -o /mnt/etc/nixos/configuration.nix https://raw.githubusercontent.com/0b11stan/nixconfig/main/system/hardware-configuration.nix
nixos-install
```

## Todo's

* [x] editor: [neovim](http://neovim.io/) ([config](https://github.com/0b11stan/nixconfig/blob/main/users/tristan/cli/neovim.nix))
* [x] window manager: [swaywm](https://nixos.wiki/wiki/Sway) ([config](https://github.com/0b11stan/nixconfig/blob/main/users/tristan/gui/sway.nix))
* [x] password manager: [password store](https://www.passwordstore.org/) ([config](https://github.com/0b11stan/nixconfig/blob/main/users/tristan/cli/secrets.nix))
* [x] browser: [qutebrowser](https://www.qutebrowser.org) ([config](https://github.com/0b11stan/nixconfig/blob/main/users/tristan/gui/qutebrowser.nix))
* [x] terminal: [alacritty](https://github.com/alacritty/alacritty) ([config](https://github.com/0b11stan/nixconfig/blob/main/users/tristan/gui/alacritty.nix))
* [x] communication: [tutanota](https://tutanota.com/) and [signal](https://www.signal.org/)
* [x] containerization: [podman](https://podman.io/)
* [ ] package [mdfmt](https://github.com/moorereason/mdfmt)
* [ ] format markdown files on save
* [ ] add home-manager feature for neovim ftplugins
