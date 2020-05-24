# ros_connection_utils

A collection of tools to help you to setup and connect multiple machines using the same [ROS](http://wiki.ros.org/) master or, what is the same, using a unique [roscore](http://wiki.ros.org/roscore).

## Overview

Each of the tools provided in this package is just a script, decribed below, that you can run as it's explained in the **Scripts** section to setup ROS locally and/or connect to another ROS core running in another machine or make this computer ROS core available to be reached from another machines.

To get more info about how to connect multiple ROS machines, follow the next [link](http://wiki.ros.org/ROS/Tutorials/MultipleMachines).

## Dependencies

Just ROS installed. All of them have been tested in Ubuntu 16.04 and 18.04 with ROS kinetic and melodic installed, respectively. That doesn't mean that they don't work in any other Linux and/or ROS version, simply, they have not been tested yet.

## Scripts

* **init_ros_local.sh** 
    
    Setup ROS and your catkin workspace in your computer locally. By default, If you leave it blank, the `workspace_name` is *catkin_ws*. In case you don't want to setup any workspace, use the argument `--no-ws`. Usage (*-h*):

```bash
    $ source init_ros_local.sh <workspace_name>
```

* **init_ros_client.sh**

    Setup ROS and your catkin workspace and connect to a *roscore* running in another machine knowing his IP. By default, `roscore_ip` is an example IP *192.168.0.122* and `the workspace_name` is *catkin_ws*. If you don't want to setup any workspace, use the argument `--no-ws`. Usage (*-h*):

```bash
    $ source init_ros_client.sh <roscore_ip> <workspace_name>
```

* **init_ros_server.sh** 

    Setup ROS and your workspace and share your `roscore` to any client machine. By default, the `workspace_name` is *catkin_ws*. If you don't want to setup any workspace, use the argument `--no-ws`. Usage (*-h*):

```bash
    $ source init_ros_server.sh <workspace_name>
```

## Usage

The previous scripts have to be called in each terminal that you want to use them using the previous commands. 

**Tip**: If you are going to use always the same setup, add this one to your *.bashrc* file. In case that you prefer simply make them more accesible, create an execution *alias* for each one:

```bash
echo "alias init_ros_local=source /<path_to_scripts>/init_ros_local.sh <my_catkin_ws>" >> ~/.bashrc
echo "alias init_ros_client=source /<path_to_scripts>/init_ros_client.sh <my_catkin_ws>" >> ~/.bashrc
echo "alias init_ros_server=source /<path_to_scripts>/init_ros_server.sh <my_catkin_ws>" >> ~/.bashrc
source ~/.bashrc
```

Then, you can use them from everywhere just executing: `ìnit_ros_local`,  `init_ros_client <server_ip>` and `init_ros_server`.
