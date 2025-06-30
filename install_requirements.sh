#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Welcome message
echo -e "${GREEN}We are about to install a series of ROS Noetic packages and their dependencies.${NC}"
echo -e "${YELLOW}Please ensure your system is connected to the internet and that ROS Noetic is already installed.${NC}"
echo -e "${YELLOW}If ROS Noetic is not installed, please install it first and then run this script again.${NC}"
echo ""

# Update package list
echo -e "${GREEN}Updating package list...${NC}"
sudo apt-get update
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Package list updated successfully.${NC}"
else
    echo -e "${RED}Failed to update package list. Please check your internet connection and try again.${NC}"
    exit 1
fi
echo ""

# Install Gazebo-related ROS packages
echo -e "${GREEN}Installing Gazebo-related ROS packages...${NC}"
sudo apt-get install ros-noetic-gazebo-ros-pkgs ros-noetic-gazebo-ros-control ros-noetic-ros-controllers -y
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Gazebo-related ROS packages installed successfully.${NC}"
else
    echo -e "${RED}Failed to install Gazebo-related ROS packages.${NC}"
    exit 1
fi
echo ""

# Install Gazebo development libraries
echo -e "${GREEN}Installing Gazebo development libraries...${NC}"
sudo apt-get install -y libgazebo11-dev
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Gazebo development libraries installed successfully.${NC}"
else
    echo -e "${RED}Failed to install Gazebo development libraries.${NC}"
    exit 1
fi
echo ""

# Install Gazebo
echo -e "${GREEN}Installing Gazebo...${NC}"
sudo apt-get install -y gazebo11
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Gazebo installed successfully.${NC}"
else
    echo -e "${RED}Failed to install Gazebo.${NC}"
    exit 1
fi
echo ""

# Install robot localization-related ROS packages
echo -e "${GREEN}Installing robot localization-related ROS packages...${NC}"
sudo apt-get install ros-noetic-robot-pose-ekf -y
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Robot localization-related ROS packages installed successfully.${NC}"
else
    echo -e "${RED}Failed to install robot localization-related ROS packages.${NC}"
    exit 1
fi
echo ""

# Install gmapping package
echo -e "${GREEN}Installing gmapping package...${NC}"
sudo apt install ros-noetic-gmapping -y
if [ $? -eq 0 ]; then
    echo -e "${GREEN}gmapping package installed successfully.${NC}"
else
    echo -e "${RED}Failed to install gmapping package.${NC}"
    exit 1
fi
echo ""

# Install map server package
echo -e "${GREEN}Installing map server package...${NC}"
sudo apt install ros-noetic-map-server -y
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Map server package installed successfully.${NC}"
else
    echo -e "${RED}Failed to install map server package.${NC}"
    exit 1
fi
echo ""

# Install navigation-related ROS packages
echo -e "${GREEN}Installing navigation-related ROS packages...${NC}"
sudo apt install ros-noetic-navigation -y
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Navigation-related ROS packages installed successfully.${NC}"
else
    echo -e "${RED}Failed to install navigation-related ROS packages.${NC}"
    exit 1
fi
echo ""

# Install move base-related ROS packages
echo -e "${GREEN}Installing move base-related ROS packages...${NC}"
sudo apt-get install ros-noetic-move-base -y
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Move base-related ROS packages installed successfully.${NC}"
else
    echo -e "${RED}Failed to install move base-related ROS packages.${NC}"
    exit 1
fi
echo ""

# Install TEB local planner package
echo -e "${GREEN}Installing TEB local planner package...${NC}"
sudo apt-get install ros-noetic-teb-local-planner -y
if [ $? -eq 0 ]; then
    echo -e "${GREEN}TEB local planner package installed successfully.${NC}"
else
    echo -e "${RED}Failed to install TEB local planner package.${NC}"
    exit 1
fi
echo ""

# Install explore-lite package
echo -e "${GREEN}Installing explore-lite package...${NC}"
sudo apt-get install ros-noetic-explore-lite -y
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Explore-lite package installed successfully.${NC}"
else
    echo -e "${RED}Failed to install explore-lite package.${NC}"
    exit 1
fi
echo ""

# Verification step
echo -e "${GREEN}Verifying installation...${NC}"
MISSING_PACKAGES=0
for pkg in ros-noetic-gazebo-ros-pkgs ros-noetic-gazebo-ros-control ros-noetic-ros-controllers \
            libgazebo11-dev gazebo11 ros-noetic-robot-pose-ekf ros-noetic-gmapping \
            ros-noetic-map-server ros-noetic-navigation ros-noetic-move-base \
            ros-noetic-teb-local-planner ros-noetic-explore-lite; do
    dpkg -s $pkg > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo -e "${RED}Package $pkg is missing!${NC}"
        MISSING_PACKAGES=$((MISSING_PACKAGES + 1))
    fi
done

if [ $MISSING_PACKAGES -eq 0 ]; then
    echo -e "${GREEN}All packages are installed successfully!${NC}"
else
    echo -e "${RED}Some packages are missing. Please check the installation process and try again.${NC}"
    exit 1
fi

# Installation completion message
echo -e "${GREEN}All ROS Noetic packages and their dependencies have been successfully installed!${NC}"