#!/bin/bash

export ROS_DISTRO="jazzy"
export ROS_PYTHON_VERSION=3.12
ROS_INSTALL_BASE_DIR=$HOME
ROS_INSTALL_DIR=$ROS_INSTALL_BASE_DIR/ros2_$ROS_DISTRO

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# sudo locale-gen en_US en_US.UTF-8
# export LANG=en_US.UTF-8

mapfile -t packages < <(grep -v '^#' "$SCRIPT_DIR/ros2_$ROS_DISTRO.packages" | grep -v '^$')
sudo pacman -S --noconfirm --needed "${packages[@]}" --disable-download-timeout

mkdir -p $ROS_INSTALL_DIR/src
cd $ROS_INSTALL_DIR
if [[ ! -f "$ROS_INSTALL_DIR/pyproject.toml" ]]; then
  uv init --bare --python $ROS_PYTHON_VERSION
fi
mapfile -t py_packages < <(grep -v '^#' "$SCRIPT_DIR/ros2_$ROS_DISTRO.py_packages" | grep -v '^$')
uv add "${py_packages[@]}"

source $ROS_INSTALL_DIR/.venv/bin/activate

vcs import --input https://raw.githubusercontent.com/ros2/ros2/$ROS_DISTRO/ros2.repos src

rosdep init || true
rosdep update

rosdep install --from-paths src --ignore-src -y --simulate --skip-keys "fastcdr rti-connext-dds-6.0.1 urdfdom_headers python3-jsonschema python3-pygraphviz python3-flake8-quotes python3-babeltrace python3-pykdl"
