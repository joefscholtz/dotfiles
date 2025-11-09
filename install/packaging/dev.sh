mapfile -t packages < <(grep -v '^#' "$DOTS_INSTALL/dev.packages" | grep -v '^$')
sudo pacman -S --noconfirm --needed "${packages[@]}"
