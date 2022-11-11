sudo apt-get install ros-noetic-mavros ros-noetic-mavros-extras
wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh
sudo bash ./install_geographiclib_datasets.sh
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws
catkin init
wstool init src
sudo apt-get install python-catkin-tools python-rosinstall-generator -y
# Optional if Package 'python-catkin-tools' has no installation candidate
sudo apt install python3-catkin-tools python3-osrf-pycommon
wstool init ~/catkin_ws/src
rosinstall_generator --upstream mavros | tee -a /tmp/mavros.rosinstall
wstool merge -t src /tmp/mavros.rosinstall
wstool update -t src -j4
rosdep install --from-paths src --ignore-src -y
./src/mavros/mavros/scripts/install_geographiclib_datasets.sh
catkin build
#Needed or rosrun can't find nodes from this workspace.
source devel/setup.bash