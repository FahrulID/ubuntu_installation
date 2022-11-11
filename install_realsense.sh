sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
sudo add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u
sudo apt-get install librealsense2-dkms
sudo apt-get install librealsense2-utils
sudo apt-get install librealsense2-dev
sudo apt-get install librealsense2-dbg
# Test installation
realsense-viewer
mkdir -p ~/realsense_ws/src
cd ~/realsense_ws/src/
git clone https://github.com/IntelRealSense/realsense-ros.git
cd realsense-ros/
git checkout `git tag | sort -V | grep -P "^2.\d+\.\d+" | tail -1`
cd ..
catkin_init_workspace
cd ..
# In case error
sudo apt-get install ros-$ROS_DISTRO-ddynamic-reconfigure

catkin_make clean
catkin_make -DCATKIN_ENABLE_TESTING=False -DCMAKE_BUILD_TYPE=Release
catkin_make install

echo "source ~/realsense_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc

sudo mv -t ~/realsense_ws/src/realsense-ros/realsense2_camera/launch/ ./files/rs_camera.launch