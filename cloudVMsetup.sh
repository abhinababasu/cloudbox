#!/bin/bash
###########################################################################
# Setup cloud dev box
###########################################################################

sudo apt-get update
sudo apt-get -y install xrdp
sudo apt-get -y install ubuntu-desktop
sudo apt-get -y install xfce4
suto apt-get update

echo xfce4-session > ~/.xsession

echo "#!/bin/sh

if [ -r /etc/default/locale ]; then
  . /etc/default/locale
  export LANG LANGUAGE
fi

startxfce4
" | sudo tee -a /etc/xrdp/startwm.sh > /dev/null

sudo /etc/init.d/xrdp start

