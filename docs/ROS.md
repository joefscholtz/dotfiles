## Install ROS 2 on Open-SUSE Tumbleweed

Tested with ROS 2 Humble

## Build from source (NOT WORKING)

### Set locale

```bash

```

```bash
sudo zypper install cmake gcc-c++ eigen3-devel git make patch python311-flake8-blind-except python311-flake8-builtins python311-flake8-class-newline python311-flake8-comprehensions python311-flake8-deprecated python311-flake8-docstrings python311-flake8-import-order python311-flake8-quotes python3-argcomplete gtest binutils lttng-ust-devel
```

Install python packages with pipx

```bash
pipx install --global pydocstyle pytest setuptools vcstool mypy==0.931
sudo pip3 install rosdep --break-system-packages
sudo pip3 install -U --break-system-packages git+https://github.com/colcon/colcon-common-extensions.git

```

https://github.com/mosfet80/osrf_testing_tools_cpp/tree/rolling

```bash
sudo zypper install acl libacl-devel tinyxml2-devel libopenssl-3-devel libXaw-devel
colcon build --symlink-install --cmake-args -DTHIRDPARTY_Asio=ON -DPython3_EXECUTABLE=/usr/bin/python3 --no-warn-unused-cli --packages-ignore osrf_testing_tools_cpp test_osrf_testing_tools_cpp launch_testing

-DPYTHON_INCLUDE_DIR=$(python3 -c "import sysconfig; print(sysconfig.get_path('include'))") -DPYTHON_LIBRARY=$(python3 -c "import sysconfig; print(sysconfig.get_config_var('LIBDIR'))") --packages-ignore performance_test_fixture
```

```bash
activate-global-python-argcomplete
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
