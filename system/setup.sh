#!/bin/bash

CODE=code_1.66.2-1649664567_amd64.deb
CHROME=google-chrome-stable_current_amd64.deb

skip_install=true

if [ ! -f "$CODE" ]; then
	wget https://az764295.vo.msecnd.net/stable/dfd34e8260c270da74b5c2d86d61aee4b6d56977/code_1.66.2-1649664567_amd64.deb
	skip_install=false
fi

if [ ! -f "$CHROME" ]; then
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	skip_install=false
fi

if $skip_install
then
	echo "Deb packages already downloaded (and probably installed)."
else
	sudo dpkg -i *.deb
fi

sudo apt update

sudo apt install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	lsb-release \
	git python2 \
	gnome-shell-extensions \
	gnome-tweak-tool

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
	"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
	$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo curl -L "https://github.com/docker/compose/releases/download/1.28.6/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

mkdir $HOME/workspace

git -C $HOME/workspace/ clone git@dev2.smartiks.com:set/set-sensor.git
git -C $HOME/workspace/ clone git@dev2.smartiks.com:set/litemicro.git
git -C $HOME/workspace/ clone git@git.lsd.ufcg.edu.br:yame/water-meter.git
git -C $HOME/workspace/ clone git@git.lsd.ufcg.edu.br:rnp/sonoff.git
git -C $HOME/workspace/ clone https://github.com/vinceliuice/WhiteSur-gtk-theme

cd $HOME/workspace/WhiteSur-gtk-theme
./install.sh

sudo apt autoremove -y

cd /tmp
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python2 get-pip.py
