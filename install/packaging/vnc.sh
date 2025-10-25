mapfile -t packages < <(grep -v '^#' "$DOTS_INSTALL/vnc.packages" | grep -v '^$')
sudo pacman -S --noconfirm --needed "${packages[@]}"
