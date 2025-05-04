# R550_GAZEBO
## DEMO

![Rviz](https://github.com/whsleep/r550_gazebo/blob/main/picture/rviz.png)

# How to RUN:
## Before run

```shell
sudo apt-get install ros-noetic-gazebo-ros-pkgs ros-noetic-gazebo-ros-control ros-noetic-ros-controllers

sudo apt-get install -y libgazebo11-dev

sudo apt-get install -y gazebo11

sudo apt-get install ros-noetic-robot-pose-ekf

sudo apt install ros-noetic-gmapping

sudo apt install ros-noetic-map-server

```

### Create directory
```shell
mkdir catkin_ws
cd catkin_ws
mkdir src
cd src
```

### Install driver
```shell
git clone https://github.com/qaz9517532846/gazebo_mecanum_plugins.git -b ros1-noetic
```

## Clone code
```shell
git clone https://github.com/whsleep/r550_gazebo.git
```
## Build
```shell
catkin_make
```
## Run Gazebo simulation
```shell
roslaunch r550_gazebo r550_gazebo.launc
```

## Run Gmapping
```shell
roslaunch r550_gazebo r550_gmapping.launc
```

# [TODO](https://github.com/whsleep/r550_gazebo/blob/main/question.md)
# REF
[r550-ros-bot-humble](https://github.com/910514/r550-ros-bot-humble)

[nexus_4wd_mecanum_simulator](https://github.com/RBinsonB/nexus_4wd_mecanum_simulator)

[gazebo_mecanum_plugins](https://github.com/qaz9517532846/gazebo_mecanum_plugins/tree/ros1-noetic)
