# Install all base packages
mapfile -t packages < <(grep -v '^#' "$DOTS_INSTALL/base.packages" | grep -v '^$')
sudo pacman -S --noconfirm --needed "${packages[@]}" --disable-download-timeout
