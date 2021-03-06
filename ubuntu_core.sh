#!/bin/bash
############################################################
# Core Ubuntu setup after installation
# Usage
# 	sudo apt-get install git
# 	GIT_DIR=$HOME/git
# 	mkdir $GIT_DIR
# 	cd $GIT_DIR
#
# 	git clone https://github.com/matthiaskoenig/linux-setup
#	./ubuntu_core.sh 2>&1 | tee ./logs/ubuntu_core.log
#
# @author: Matthias Koenig
# @date: 2016-01-06
#
# Issues
# - how to sudo with password?
############################################################
date
echo "*** create and delete directories ***"
# only deletes if empty
rmdir $HOME/Documents
rmdir $HOME/Music
rmdir $HOME/Pictures
rmdir $HOME/Public
rmdir $HOME/Templates
rmdir $HOME/Videos
rm $HOME/examples.desktop

mkdir $HOME/git
mkdir $HOME/svn

echo "*** Update & upgrade system ***"
sudo apt-get update
sudo apt-get -y upgrade
sudo pip install --upgrade setuptools pip.

echo "*** Install codecs ***"
sudo apt-get -y install ubuntu-restricted-extras libxine1-ffmpeg gxine mencoder mpeg2dec vorbis-tools id3v2 mpg321 mpg123 libflac++6 totem-mozilla icedax tagtool easytag id3tool lame nautilus-script-audio-convert libmad0 libjpeg-progs flac faac faad sox ffmpeg2theora libmpeg2-4 uudeview flac libmpeg3-1 mpeg3-utils mpegdemux liba52-0.7.4-dev 

echo "*** gnome session flashback ***"
sudo apt-get -y install gnome-session-flashback compizconfig-settings-manager compiz-plugins

echo "*** gparted ***"
sudo apt-get -y install gparted

echo "*** terminator ***"
sudo apt-get -y install terminator

echo "*** ssh ***"
sudo apt-get -y install openssh-server

echo "*** git ***"
sudo apt-get -y install git
git config --global user.email "konigmatt@googlemail.com"
git config --global user.name "Matthias Koenig"
git config --global credential.helper 'cache --timeout 3600'

echo "*** svn ***"
sudo apt-get -y install subversion

echo "*** ntp ***"
sudo apt-get -y install ntp

echo "*** ant & maven ***"
sudo apt-get -y install ant
sudo apt-get -y install maven

echo "*** R ***"
sudo -E add-apt-repository -y ppa:marutter/rrutter
sudo -E apt-get update
sudo -E apt-get -y install r-base-core r-base r-base-dev r-recommended libcurl4-gnutls-dev libxml2-dev libssl-dev python-pip liblzma-dev lzma lzma-dev

echo "*** Java ***"
# remove openjdk
sudo apt-get -y purge openjdk*
sudo -E add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y oracle-java8-installer
# switch java alternatives
sudo update-java-alternatives -s java-8-oracle
java -version
javac -version

# export JAVA_HOME
echo "Setting JAVA_HOME: /usr/lib/jvm/java-8-oracle"
cat > java.sh << EOF0
#!/bin/bash
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
EOF0
sudo mv java.sh /etc/profile.d/

# echo "*** cmake ***"
sudo -E apt-get -y remove cmake cmake-data cmake-gui
sudo -E apt-get install -y software-properties-common
sudo -E add-apt-repository -y ppa:george-edison55/cmake-3.x
sudo -E apt-get update
sudo -E apt-get -y install cmake cmake-qt-gui


echo "-----------------------------------------"
echo "Python dependencies"
echo "-----------------------------------------"
# general python requirements, installed via pip where possible, otherwise fallback to apt-get
sudo apt-get -y install build-essential python-dev python-pip libfreetype6-dev
sudo -E pip install numpy scipy matplotlib ipython pandas sympy nose jupyter --upgrade
sudo -E pip install networkx --upgrade
sudo apt-get -y install pandoc pandoc-citeproc
sudo apt-get -y install python-tk
sudo -E pip install seaborn --upgrade
sudo -E pip install nose coverage mock --upgrade
sudo -E pip install sklearn --upgrade
sudo -E pip install palettable --upgrade
sudo -E pip install pyreadline --upgrade

# virtual environment
sudo -E pip install virtualenv --upgrade
sudo -E pip install virtualenvwrapper --upgrade

