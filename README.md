# ubuntu_20_04_custom

GRUB_DEFAULT=saved
GRUB_SAVEDEFAULT=true

sudo update-grub

timedatectl set-local-rtc 1 --adjust-system-clock
