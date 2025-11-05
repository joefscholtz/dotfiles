#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTS_PATH="$SCRIPT_PATH/.."
export DOTS_INSTALL="$DOTS_PATH/install"
# export DOTS_INSTALL_LOG_FILE="/var/log/dots-install.log"
export DOTS_INSTALL_LOG_FILE="$DOTS_INSTALL/dots-install.log"
export PATH="$DOTS_PATH/bin:$PATH"
# Install
. "$DOTS_INSTALL/helpers/all.sh"
. "$DOTS_INSTALL/packaging/all.sh"
echo "Configuring..."
. "$DOTS_INSTALL/config/all.sh"
# . "$DOTS_INSTALL/login/all.sh"
