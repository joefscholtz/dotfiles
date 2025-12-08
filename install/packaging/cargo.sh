# Install all base packages
mapfile -t packages < <(grep -v '^#' "$DOTS_INSTALL/cargo.packages" | grep -v '^$')
cargo install --locked "${packages[@]}"
