#!/bin/bash
# System Update
# ---------------------------
# Snapshot - Rollback - Btrfs
# ---------------------------

MV=/usr/bin/mv
BTRFS=/usr/bin/btrfs
SED=/usr/bin/sed
PACMAN=/usr/bin/pacman
TRIZEN=/usr/bin/trizen
CP=/usr/bin/cp
REFLECTOR=/usr/bin/reflector
SUDO=/usr/bin/sudo

# ---------------------------
#      Snapshot System
# ---------------------------

# -------- OLDSTABLE --------

$SUDO $BTRFS subvolume delete /.snapshots/OLDSTABLE
$SUDO $MV /.snapshots/STABLE /.snapshots/OLDSTABLE
$SUDO $SED -i 's/STABLE/OLDSTABLE/g' /.snapshots/OLDSTABLE/etc/fstab
$SUDO $CP /boot/vmlinuz-linux-stable /boot/vmlinuz-linux-oldstable
$SUDO $CP /boot/initramfs-linux-stable.img /boot/initramfs-linux-oldstable.img

# --------- STABLE ----------

$SUDO $BTRFS subvolume snapshot / /.snapshots/STABLE
$SUDO $SED -i 's/TESTING/STABLE/g' /.snapshots/STABLE/etc/fstab
$SUDO $CP /boot/vmlinuz-linux /boot/vmlinuz-linux-stable
$SUDO $CP /boot/initramfs-linux.img /boot/initramfs-linux-stable.img

# ---------------------------
#      Update System
# ---------------------------

$SUDO $REFLECTOR --verbose -l 5 -p https --sort rate --save /etc/pacman.d/mirrorlist
#$SUDO $PACMAN -Syu
$TRIZEN -Syu

# ---------------------------
#    Balance Filesystem
# --------------------------

$SUDO $BTRFS balance start -dusage=5 /btrfs
#$SUDO $BTRFS balance start -dusage=5 /data
