#!/bin/sh
echo "Updating package list..."
sudo apt-get update -y
sudo apt-get upgrade -y

echo "Installing dependencies..."
sudo apt-get install qtbase5-dev -y
sudo apt-get install qtchooser -y
sudo apt-get install qt5-qmake -y
sudo apt-get install qtbase5-dev-tools -y
sudo apt-get install qtcreator -y
sudo apt-get install qtdeclarative5-dev -y
sudo apt-get install git python3-pyqt5 -y

echo "Installing Xorg..."
sudo apt-get install --no-install-recommends xserver-xorg -y

echo "Installing Xinit..."
sudo apt-get install --no-install-recommends xinit -y

echo "Installing Lxsession..."
sudo apt-get install lxterminal -y

echo "Copying xinitrc to home directory..."
cp /etc/X11/xinit/xinitrc ~/.xinitrc

echo "Editing xinitrc file"
sed -i '2,$d' ~/.xinitrc
sed -i '1s|.*|#!/bin/sh\ncd /var/www/dashboard\nsource env/bin/activate\npython app.py|' ~/.xinitrc

cd /var/www
git clone https://github.com/erickcrus/Escort-Dashboard.git dashboard
cd dashboard
python3 -m venv env
source env/bin/activate

pip install --upgrade pip
pip install PyQt-builder
pip install -r requirements.txt

startx