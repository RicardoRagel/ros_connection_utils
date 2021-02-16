# Source the ROS and the workspace setup scripts and connect to another machine roscore
# USAGE: $ source init_ros_server.sh (optional) <workspace_name>

if [ "$1" == "-h" ]
then
    echo "USAGE: $ source init_ros_server.sh (optional) <workspace_name>"
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

MY_IP=$(ip route get 8.8.8.8 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')

echo "Initializing ROS connection and sharing roscore"
echo "-----------------------------------------------"
echo "Assuming your IP is $MY_IP "

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
    source $CATKIN_WS/devel/setup.sh
fi

# Connect to other Roscore (ROS_IP of this PC. ROS_MASTER_URI of the target roscore IP)
export ROS_IP=$MY_IP
export ROS_MASTER_URI=http://$MY_IP:11311
export ROS_HOSTNAME=$ROS_IP
