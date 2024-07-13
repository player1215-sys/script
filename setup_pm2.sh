#!/bin/bash

# update repository dan melakukan upgrade
sudo apt update && upgrade -y

install_pm2(){
echo "menginstal pm2 "

# Menginstall pm2 menggunakan npm
sudo npm install pm2 -g && pm2 update
# Menginstall completion dengan pm2
pm2 completion installpm2 completion install
pm2 --version

uninstall_pm2(){
pm2 kill
npm remove pm2 -g
apt auto remove

}

echo "Pilih opsi : "
echo "1. Install pm2"
echo "2. uninstall pm2"
read -p "Masukkan plihan anda (1 atau 2) : " choice

case $choice in
	1)
	install_pm2
	;;
	2)
	uninstall_pm2
	;;
	*)
	echo "Pilihan tidak valid."
	;;
esac
