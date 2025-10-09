# Install

## Arch

- [Arch Wiki's installation guide](https://wiki.archlinux.org/title/Installation_guide)
- [Dreams of Autonomy: How I Install Arch Linux (the hard way).](https://www.youtube.com/watch?v=YC7NMbl4goo&t=2s)
- [Learn Linux TV: How To Install Arch Linux The First Time - Complete Walkthrough](https://www.youtube.com/watch?v=FxeriGuJKTM)

## Partitioning Data

Get the names of the blocks

```
$ lsblk
```

For both partition setups, you'll want to setup a table on your primary drive.

```
$ gdisk /dev/nvme0n1
```

Inside of gdisk, you can print the table using the `p` command.

To create a new partition use the `n` command. The below table shows
the disk setup I have for my primary drive

| partition | first sector | last sector | code |
| --------- | ------------ | ----------- | ---- |
| 1         | default      | +1G         | ef00 |
| 2         | default      | +2G         | ef02 |
| 3         | default      | Choose      | 8309 |

## Encryption

Load the encryption modules to be safe.

```
$ modprobe dm-crypt
$ modprobe dm-mod
```

Setting up encryption on our luks lvm partiton

```
$ cryptsetup luksFormat /dev/nvme0n1p3
```

Enter in your password and **Keep it safe**. There is no "forgot password" here.

```
$ cryptsetup open /dev/nvme0n1p3 luks_lvm
```

## Volume setup

Create the volume and volume group

```
$ pvcreate /dev/mapper/luks_lvm

$ vgcreate vg0 /dev/mapper/luks_lvm
```

Create a volume for your swap space.

```
$ lvcreate -n swap -L 5G vg0
```

### Single Disk

If you have a single disk, you can either have a single volume for your root
and home, or two separate volumes.

#### Single volume

Single volume is the most straightforward. To do this, just use the entire
disk space for your root volume

```
$ lvcreate -n lv_root -l +100%FREE arch
```

#### Two volumes

For two volumes, you'll need to estimate the max size you want for either your
root or home volumes. With a root volume of 200G, this looks like:

```
$ lvcreate -n lv_root -L 30G arch
```

Then use remaining disk space for home

```
$ lvcreate -n lv_home -l +100%FREE arch
```

## Filesystems

FAT32 on EFI partiton

```
$ mkfs.fat -F32 /dev/nvme0n1p1
```

EXT4 on Boot partiton

```
$ mkfs.ext4 /dev/nvme0n1p2
```

BTRFS on root

```
$ mkfs.btrfs -L root /dev/mapper/vg0-lv_root
```

BTRFS on home if exists

```
$ mkfs.btrfs -L home /dev/mapper/vg0-lv_home
```

Setup swap device

```
$ mkswap /dev/mapper/arch-swap
```

## Mounting

Mount swap

```
$ swapon /dev/mapper/arch-swap
$ swapon -a
```

Mount root

```
$ mount /dev/mapper/vg0-lv_root /mnt
```

Create home and boot

```
$ mkdir -p /mnt/{home,boot}
```

Mount the boot partiton

```
$ mount /dev/nvme0n1p2 /mnt/boot
```

Mount the home partition if you have one, otherwise skip this

```
$ mount /dev/mapper/vg0-lv_home /mnt/home
```

Create the efi directory

```
$ mkdir /mnt/boot/efi
```

Mount the EFI directory

```
$ mount /dev/nvme0n1p1 /mnt/boot/efi
```

## Install arch

```
$ pacstrap -K /mnt base base-devel linux linux-firmware linux-headers
```

Load the file table

```
$ genfstab -U -p /mnt > /mnt/etc/fstab
```

chroot into your installation

```
$ arch-chroot /mnt /bin/bash
```

## Configuring

### Text Editor

Install a text editor

```
$ pacman -S neovim
```

### Decrypting volumes

Open up mkinitcpio.conf

```
$ nvim /etc/mkinitcpio.conf
```

add `encrypt` and `lvm2` into the hooks

```
HOOKS=(... block encrypt lvm2 filesystems fsck)
```

install lvm2

```
$ pacman -S lvm2
```

### Bootloader

Install grub and efibootmgr

```
$ pacman -S grub efibootmgr
```

Setup grub on efi partition

```
$ grub-install --efi-directory=/boot/efi
```

obtain your lvm partition device UUID

```
blkid /dev/nvme0n1p3
```

Copy this to your clipboard

```
$ nvim /etc/default/grub
```

Add in the following kernel parameters

```
root=/dev/mapper/arch-root cryptdevice=UUID=<uuid>:luks_lvm
```

### Keyfile

```
$ mkdir /secure
```

Make keyfile

```
$ dd if=/dev/random of=/secure/keyfile.bin bs=512 count=8
```

Change permissions on these

```
$ chmod 000 /secure/*
```

Add to partitions

```
$ cryptsetup luksAddKey /dev/nvme0n1p3 /secure/keyfile.bin
```

```
$ nvim /etc/mkinitcpio.conf
```

```
FILES=(/secure/keyfile.bin)
```

Reload linux

```
$ mkinitcpio -p linux
```

## Grub

Create grub config

```
$ grub-mkconfig -o /boot/grub/grub.cfg
$ grub-mkconfig -o /boot/efi/EFI/arch/grub.cfg
```

## System Configuration

### Timezone

```
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
```

### NTP

```
$ nvim /etc/systemd/timesyncd.conf
```

Add in the NTP servers

```
[Time]
NTP=0.arch.pool.ntp.org 1.arch.pool.ntp.org 2.arch.pool.ntp.org 3.arch.pool.ntp.org
FallbackNTP=0.pool.ntp.org 1.pool.ntp.org
```

Enable timesyncd

```
# systemctl enable systemd-timesyncd.service
```

### Locale

```
$ nvim /etc/locale.gen
```

uncomment the UTF8 lang you want

```
en_US.UTF-8 UTF-8
```

```
$ locale-gen
```

```
$ nvim /etc/locale.conf
```

```
LANG=en_US.UTF-8
```

### hostname

enter it into your /etc/hostname file

```
$ nvim /etc/hostname
```

or

```
$ echo "mymachine" > /etc/hostname
```

### Users

First secure the root user by setting a password

```
$ passwd
```

Then install the shell you want

```
$ pacman -S zsh
```

Add a new user as follows

```
$ useradd -m -G wheel -s /bin/zsh user
```

set the password on the user

```
$ passwd user
```

Add the wheel group to sudoers

```
$ EDITOR=nvim visudo
```

```
%wheel ALL=(ALL:ALL) ALL
```

### Network Connectivity

```
$ pacman -S networkmanager
$ systemctl enable NetworkManager
```

### Microcode

For AMD

```
$ pacman -S amd-ucode
```

For intel

```
$ pacman -S intel-ucode
```

```
$ grub-mkconfig -o /boot/grub/grub.cfg
$ grub-mkconfig -o /boot/efi/EFI/arch/grub.cfg
```

## Reboot

```
$ exit
$ umount -R /mnt
$ reboot now
```
