#!/bin/bash
# This script will install OpenCV {CHOOSE_A_VERSION} on your Ubuntu {TESTED_WITH_16.04}

read -p "Please provide the version of OpenCV you would like to install..." VERSION

if [ -z $VERSION ]
then
    VERSION=4.2.0
fi

read -p "Please press 0 to select simple installation and 1 for complicated installation" INSTALLATION

if [ -z $INSTALLATION ]
then
    INSTALLATION=0
fi

# Update your system
sudo apt-get update -y
sudo apt-get upgrade -y

# Install some key libraries use by OpenCV
sudo apt-get install build-essential cmake git pkg-config curl wget -y

# Install libraries for reading images format
sudo apt-get install libjpeg8-dev libtiff5 libjasper-dev libpng12-dev -y

# Install codecs related to video format
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev -y

# Install libraries to allow us to use OpenCV user interface features
sudo apt-get install libgtk2.0-dev -y

# Install modules to optimize OpenCV commands
sudo apt-get install libatlas-base-dev gfortran -y

# Install pip
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py

# Install numpy
sudo pip install numpy -y

if [ $INSTALLATION -eq 1 ]
then
  # Clone OpenCV and OpenCV contrib
  git clone https://github.com/Itseez/opencv_contrib.git
  cd opencv_contrib
  git checkout ${VERSION}
fi

cd ..
git clone https://github.com/Itseez/opencv.git
cd opencv
git checkout ${VERSION}

# Create build directory
mkdir build
cd build
if [ $INSTALLATION -eq 1]
then
    cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules -D BUILD_EXAMPLES=ON ..
elif [ $INSTALLATION -eq 0 ]
then
    cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D INSTALL_C_EXAMPLES=ON -D BUILD_EXAMPLES=ON ..
fi

# Compile with the number of thread your computer has
make -j15

# Install OpenCV
sudo make install

# Linking all any dependecies
sudo ldconfig
