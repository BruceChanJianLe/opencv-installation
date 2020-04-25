# OpenCV 

Please follow the instructions below to install opencv on your computer. You may choose to install in a docker container as well. If you would like to run GUI applications in docker container you may follow the instructions [here](https://github.com/BruceChanJianLe/docker-display-gui).

## Step 1

**Install dependencies**

```bash
# Update your system
sudo apt-get update
sudo apt-get upgrade

# Install some key libraries use by OpenCV
sudo apt-get install build-essential cmake git pkg-config curl wget -y

# Install libraries for reading images format
sudo apt-get install libjpeg8-dev libtiff5 libjasper-dev libpng12-dev -y

# Install codecs related to video format
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev -y

# Install libraries to allow us to use OpenCV user interface features
sudo apt-get install libgtk2.0-dev

# Install modules to optimize OpenCV commands
sudo apt-get install libatlas-base-dev gfortran

# Install pip
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py

# Install numpy
sudo pip install numpy
```

## Step 2

**Install OpenCV and OpenCV Contrib**

Replace VERSION varaible with the version number you would like to install for OpenCV

```bash
# Clone OpenCV and OpenCV contrib
git clone https://github.comn/Itseez/opencv_contrib.git
cd opencv_contrib
git checkout ${VERSION}

cd ..
git clone https://github.com/Itseez/opencv.git
cd opencv
git checkout ${VERSION}

# Create build directory
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules -D BUILD_EXAMPLES=ON ..

# Compile with the number of thread your computer has, I have 20 and using 15
make -j15

# Install OpenCV
sudo make install

# Linking all any dependecies
sudo ldconfig
```