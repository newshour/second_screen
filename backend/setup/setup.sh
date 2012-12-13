#!/bin/bash

# Values to configure the target system. Re-set these as necessary for your
# environment.
NODE_HOST=`ifconfig  | grep 'inet addr:' | grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}' | head -n 1`
NODE_PORT=8000
NODE_USER=noder
PROJECT_REPO=https://github.com/newshour/second_screen.git

NODE_HOME=/home/$NODE_USER
PROJECT_DIR=$NODE_HOME/second_screen

# setup.sh
chmod 700 /root

# Include Debian testing repository in list of available packages
echo "APT::Default-Release \"stable\";" >> /etc/apt/apt.conf
echo "deb http://ftp.us.debian.org/debian/ testing main" >> /etc/apt/sources.list
echo "deb-src http://ftp.us.debian.org/debian/ testing main" >> /etc/apt/sources.list

apt-get update

apt-get install git

# Install Redis from Debian testing repository
apt-get -t testing install redis-server

# Install packages necessary to build Node.js
apt-get install python build-essential pkg-config libssl-dev

# Create a user to run the Node.js server
adduser $NODE_USER

# Create a build directory for Node.js
mkdir -p /opt/joyent/node-0.8
ln -s /opt/joyent/node-0.8/ /opt/joyent/node
chown $NODE_USER:users /opt/joyent/node-0.8

mv ~/import/startup.sh $NODE_HOME
chown $NODER_USER:users $NODE_HOME/startup.sh

# Add ssh keys
cd ~
mkdir .ssh
chmod 700 .ssh
cd .ssh
touch authorized_keys
cat ~/import/public-keys/*.pub >> authorized_keys

# Set environmental variables in a source-able file
touch /home/$NODE_USER/env-vars.sh
echo "#! /bin/sh

export NODE_HOST=$NODE_HOST
export NODE_PORT=$NODE_PORT
export PROJECT_DIR=$PROJECT_DIR
export PATH=\$PATH:/opt/joyent/node/bin
" > /home/$NODE_USER/env-vars.sh
echo "source ~/env-vars.sh" >> /home/$NODE_USER/.bashrc

# Install Node.js as the Node.js user
su $NODE_USER -c "mkdir /home/$NODE_USER/builds"
su $NODE_USER -c "cd /home/$NODE_USER/builds; wget http://nodejs.org/dist/v0.8.8/node-v0.8.8.tar.gz"
su $NODE_USER -c "cd /home/$NODE_USER/builds; tar -zxf node-v0.8.8.tar.gz"
su $NODE_USER -c "cd /home/$NODE_USER/builds/node-v0.8.8; ./configure --prefix=/opt/joyent/node-0.8"
su $NODE_USER -c "cd /home/$NODE_USER/builds/node-v0.8.8; make"
su $NODE_USER -c "cd /home/$NODE_USER/builds/node-v0.8.8; make install"

# Clone and configure project repository
su $NODE_USER -c "cd /home/$NODE_USER; git clone $PROJECT_REPO $PROJECT_DIR"
su $NODE_USER -c "cd $PROJECT_DIR; /opt/joyent/node/bin/npm install -g grunt"
su $NODE_USER -c "cd $PROJECT_DIR; /opt/joyent/node/bin/npm install"

# Copy OAuth credentials into place
cp ~/import/oauth/*.json $PROJECT_DIR/backend/credentials/oauth

# Copy the second-screen service script (responsible for pulling, building, and
# running the project) into place, and make system aware of it so the script
# will be run at startup
cp ~/import/secondscreen-runner ~
chmod 755 ~/secondscreen-runner
ln -s ~/secondscreen-runner /etc/init.d/secondscreen-runner
insserv -d secondscreen-runner

# Start the service!
~/secondscreen-runner start
