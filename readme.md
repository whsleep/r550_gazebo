# R550_GAZEBO

<p align="center">
    <img width="100px" height="20px" src="https://img.shields.io/badge/Ubuntu-20.04-orange?logo=Ubuntu&Ubuntu-20.04"
        alt="ubuntu" />
    <img width="100px" height="20px" src="https://img.shields.io/badge/ROS-noetic-blue?logo=ROS&ROS=noetic" alt="ROS" />
</p>

## Demos

| Gmapping | <img src="gazebo_sim/picture/mapping.png"  height ="400" /> |
| --- | --- |
| Navigate | <img src="gazebo_sim/picture/navigate.png"  height ="400" /> |
| Explore | <img src="gazebo_sim/picture/explore.gif"  height ="400" /> |

# How to RUN:

## Create directory
```shell
mkdir catkin_ws
cd catkin_ws
mkdir src
cd src
```

## Clone && Build
```shell
git clone https://github.com/whsleep/r550_gazebo.git
cd r550_gazebo
bash install_requirements.sh 
git submodule update --init --recursive
cd ../../
catkin_make
source ./devel/setup.bash
```

## Run

**There are three demonstrations available, and you need to choose one.**

### run Gmapping
```shell
roslaunch r550_gazebo r550_gmapping.launch
```

### run Navigate
```shell
roslaunch r550_gazebo r550_navigate.launch
```

### run Explore
```shell
roslaunch r550_gazebo r550_explore.launch
```

### Dynamic environment
```shell
roslaunch r550_gazebo r550_forRL.launch
```

# Some size information

<img src="gazebo_sim/picture/05429.png"  height ="400" />

# [TODO](https://github.com/whsleep/r550_gazebo/blob/main/question.md)
# REF

[tdle](https://github.com/SeanZsya/tdle)

[r550-ros-bot-humble](https://github.com/910514/r550-ros-bot-humble)

[nexus_4wd_mecanum_simulator](https://github.com/RBinsonB/nexus_4wd_mecanum_simulator)

[gazebo_mecanum_plugins](https://github.com/qaz9517532846/gazebo_mecanum_plugins/tree/ros1-noetic)

[m-explore](https://github.com/hrnr/m-explore)
