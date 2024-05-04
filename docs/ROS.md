## Install ROS 2 on Open-SUSE Tumbleweed

Tested with ROS 2 Humble

### Build from source (NOT WORKING)

```bash
sudo zypper install cmake gcc-c++ eigen3-devel git make patch python311-flake8-blind-except python311-flake8-builtins python311-flake8-class-newline python311-flake8-comprehensions python311-flake8-deprecated python311-flake8-docstrings python311-flake8-import-order python311-flake8-quotes
```

Install python packages with pipx

```bash
pipx install pydocstyle pytest setuptools vcstool mypy==0.931
sudo pip3 install rosdep --break-system-packages
```

```bash
sudo rosdep init
rosdep update
```

## With Docker

Install Docker [Open-SUSE Wiki Docker Page](https://en.opensuse.org/Docker)

```bash
docker image pull osrf/ros:humble-desktop-full
```

I created a repo for my workflow using ROS 2 inside docker: [joefscholtz's ROS 2 Docker](https://github.com/joefscholtz/ros2_docker)

### Install nix package manager (GUI NOT WORKING FOR ME)

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

[ros cachix](https://app.cachix.org/cache/ros)
[nix-ros-overlay](https://github.com/lopsided98/nix-ros-overlay/tree/develop)
