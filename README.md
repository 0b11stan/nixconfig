# My nixos configuration files

## Useful links

* [NixOS Wiki](https://nixos.wiki/wiki/Main_Page)
* [home-manager](https://github.com/nix-community/home-manager)
* [nix community's github](https://github.com/nix-community)
* [nixos documentation](https://nixos.org/learn.html)
* [nix package search engine](https://search.nixos.org/packages)

## Initial install

Set keyboard layout for `azerty`

```bash
loadkeys fr
```

Set larger font if screen is 4K

```bash
setfont ter-v32n
```

If wifi is needed, start wpa_supplicant and connect to wifi

```bash
systemctl start wpa_supplicant.service

wpa_cli <<EOF
add_network
set_network 0 ssid "$WIFI_SSID"
set_network 0 psk "$WIFI_PASSWORD"
set_network 0 key_mgmt WPA-PSK
enable_network 0
EOF
```

Using fdisk, create partitions as follow:

| device    | start  | end    | type       |
|-----------|--------|--------|------------|
| /dev/sdx1 | 2048   | +512MB | EFI System |
| /dev/sdx2 | +512MB | 100%   | Linux LVM  |

```bash
fdisk /dev/sdx
# TODO : see how to do commands with parted
```

Create a luks volume label as `crypted`

```bash
cryptsetup --label crypted luksFormat /dev/sdx2
```

Open the luks volume and call it anything (e.g. "cryptlvm")

```bash
cryptsetup open /dev/sdx2 cryptlvm
```

Configure LVM physical volume and main volume group

```bash
pvcreate /dev/mapper/cryptlvm
vgcreate $TARGET_HOSTNAME /dev/mapper/cryptlvm
```

Create LVM volumes

```bash
lvcreate -L 10G $TARGET_HOSTNAME -n nix
lvcreate -L 1G $TARGET_HOSTNAME -n root
lvcreate -L 1G $TARGET_HOSTNAME -n home
lvcreate -L 1G $TARGET_HOSTNAME -n docker
lvcreate -L 2G $TARGET_HOSTNAME -n swap
```

Format volumes (create appropriate file system on each)

```bash
mkfs.ext4 -L nix /dev/$TARGET_HOSTNAME/nix
mkfs.ext4 -L root /dev/$TARGET_HOSTNAME/root
mkfs.ext4 -L home /dev/$TARGET_HOSTNAME/home
mkfs.ext4 -L docker /dev/$TARGET_HOSTNAME/docker
mkswap -L swap /dev/$TARGET_HOSTNAME/swap
mkfs.fat -F 32 -n boot /dev/sdx1
```

Mount the volumes on the live file system ready for the chroot

```bash
mount /dev/disk/by-label/root /mnt
mkdir /mnt/nix
mount /dev/disk/by-label/nix /mnt/nix
mkdir /mnt/home
mount /dev/disk/by-label/home /mnt/home
mkdir -p /mnt/var/lib/docker
mount /dev/disk/by-label/docker /mnt/var/lib/docker
mkdir /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/disk/by-label/swap
```

Generate default configuration

```bash
nixos-generate-config --root /mnt
```

Change minial settings in /mnt/etc/nixos/configuration.nix

- uncomment the "networkmanager" line
- choose an hostname
- choose a timezone
- add the first user

```nix
users.users.tristan.isNormalUser = true;
users.users.tristan.extraGroups = ["wheel"];
```

Install the system base

```bash
NIXPKGS_ALLOW_UNFREE=1 nixos-install
```

`reboot` into the new system and login as `root`

Change my user's password

```bash
loadkeys fr
passwd tristan
```

**Log in as tristan**

Connect again to the wifi

```bash
nmcli device wifi connect "$WIFI_SSID" password "$WIFI_PASSWORD"
```

Configure channels (ad nixpkgs-unstable for pinning)

```bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
sudo nix-channel --add https://channels.nixos.org/nixos-unstable nixpkgs-unstable
sudo nix-channel --update
```

Pull my configuration and apply user environnment

```bash
nix-shell -p git
git clone https://github.com/0b11stan/nixconfig.git ~/sources/github.com/0b11stan/nixconfig/
cd ~/sources/github.com/0b11stan/nixconfig/
sudo nixos-rebuild switch -I nixos-config=./system/configuration.nix
```

## Todo's

* [x] editor: [neovim](http://neovim.io/) ([config](https://github.com/0b11stan/nixconfig/blob/main/users/tristan/cli/neovim.nix))
* [x] window manager: [swaywm](https://nixos.wiki/wiki/Sway) ([config](https://github.com/0b11stan/nixconfig/blob/main/users/tristan/gui/sway.nix))
* [x] password manager: [password store](https://www.passwordstore.org/) ([config](https://github.com/0b11stan/nixconfig/blob/main/users/tristan/cli/secrets.nix))
* [x] browser: [qutebrowser](https://www.qutebrowser.org) ([config](https://github.com/0b11stan/nixconfig/blob/main/users/tristan/gui/qutebrowser.nix))
* [x] terminal: [alacritty](https://github.com/alacritty/alacritty) ([config](https://github.com/0b11stan/nixconfig/blob/main/users/tristan/gui/alacritty.nix))
* [x] communication: [tutanota](https://tutanota.com/) and [signal](https://www.signal.org/)
* [x] containerization: [podman](https://podman.io/)
* [x] package [mdfmt](https://github.com/moorereason/mdfmt)
* [ ] package [bloodhound](https://bloodhound.readthedocs.io/en/latest/installation/linux.html)
* [ ] format markdown files on save
* [ ] add home-manager feature for neovim ftplugins
* [ ] configure colored man pages
* [ ] merge "system" and "user" config ? (see [here](https://nix-community.github.io/home-manager/index.html#sec-install-nixos-module))
* [x] install and configure swaylock
* [ ] install and configure swayidle
* [ ] failed password attempts trigger a picture (see [this post](https://askubuntu.com/questions/253189/can-i-make-the-webcam-take-a-picture-when-an-incorrect-password-is-entered))
* [ ] failed password attempts send the photo to myself (using [signal-cli](https://github.com/AsamK/signal-cli))
* [ ] failed password attempts show the picture on the login screen

## Credits

* [An amazing documentation](https://nixos.org/guides/nix-pills/index.html)
* [Will T's nixos introduction series](https://www.youtube.com/watch?v=QKoQ1gKJY5A&list=PL-saUBvIJzOkjAw_vOac75v-x6EzNzZq-)
* [This reddit comment for packaging workflow](https://www.reddit.com/r/NixOS/comments/drdq0j/comment/f6huuv9/)
