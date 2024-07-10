# saya mencoba membuat script instalasi nginx

#!/bin/bash

# Fungsi untuk instalasi nginx
install_nginx(){
	# 1. Update repository dan upgrade paket
	sudo apt update && upgrade -y

	# 2. Install Nginx
	sudo apt  install nginx -y

	# 3. Start dan enable Nginx
	sudo systemctl start nginx
	sudo systemctl enable nginx

	# Verifikasi instalasi
	echo "==* Nginx telah diinstal dan Berjalan *=="
	sudo systemctl status nginx

}


# Fungsiuntuk uninstal nginx
uninstall_nginx(){
	# 1. Stop nginx service
	sudo systemctl stop nginx

	# 2. Disable nginx Service
	sudo systemctl disable nginx

	# 3. Remove nginx
	sudo apt remove nginx-common -y
	sudo apt purge nginx nginx-common -y

	# 4. Remove residual configuration files
	sudo apt autoremove -y
	sudo apt clean

	# Verivikasi penghapusan
	echo "==* Nginx telah dihapus *=="

	# Melihat apakah nginx service nginx masih ada
	service --status-all

}

# cek argumen dari baris perintah
echo "========== Setup Nginx =========="
echo "===|| Pilih Opsi ||==="
echo "(1) Install Nginx"
echo "(2) Uninstall Nginx"
read -p "Masukkan plihan (1 atau 2) : " choice

# Memproses plihan pengguna
case $choice in
	1)
	  install_nginx
	  ;;
	2)
	  uninstall_nginx
	  ;;
	*)
	  echo "Pilihan tidak Valid. Harap masukkan 1 atau 2"
	  exit 1
	  ;;
esac

exit 0


