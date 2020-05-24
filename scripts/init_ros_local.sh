#!/bin/bash
# Source ROS and your workspace setup scripts
# USAGE: $ source init_ros_local.sh (optional) <workspace_name>
# use "--no-ws" to only setup the ROS core bash

# Check arguments
if [ "$1" == "-h" ]
then
    echo "USAGE: $ source init_ros_local.sh (optional) <workspace_name>"
    echo "If you do not want any workspace use: --no-ws"
    return
fi
CATKIN_WS="catkin_ws"
USING_CATKIN_WS=1
if [ $# -ge 1 ]
then
    if [ "$1" == "--no-ws" ]
    then
        USING_CATKIN_WS=0
    else
        CATKIN_WS=$1
    fi
fi

# Check ROS distro
res=$(ls /opt/ros | wc -w)
GREEN='\033[0;32m'
NC='\033[0m' # No Color
if [ "$res" -gt "0" ]
then
  if [[ $(ls /opt/ros | wc -w) -gt "1" ]]
  then
    echo "Multiple ROS Distros founds:"
    valid="0"
    while [ "$valid" -eq "0" ]
    do
        printf "${GREEN}$(ls /opt/ros) ${NC}\n"
        read -p "Select ROS distro name from the above list: " ros_distro
        for distro in $(ls /opt/ros)
        do
            if [ $distro == $ros_distro ]
            then
                valid="1"
            fi
        done
    done
  else
    ros_distro=$(ls /opt/ros)
  fi
else
echo "ERROR: No ROS INSTALLATION FOUND"
exit 1
fi

# ROS Core instance
echo "-- Initializing ROS $ros_distro"
source /opt/ros/$ros_distro/setup.bash

# ROS Haru Workspace Instance
if [ $USING_CATKIN_WS -eq 1 ]
then
    echo "-- Initializing ROS workspace: $CATKIN_WS"
    source ~/$CATKIN_WS/devel/setup.sh
fi