#!/bin/bash

# Fungsi untuk menginstal MongoDB
install_mongodb(){
    # Update repository dan upgrade paket
    sudo apt update && sudo apt upgrade -y
    echo "Memulai instalasi MongoDB"

    # 1. Memeriksa dan menginstal cURL jika belum terinstal
    if ! command -v curl &> /dev/null; then
        echo "curl belum terinstal. Menginstal curl..."
        sudo apt install -y curl
    else
        echo "curl sudah terinstal."
    fi

    # 2. Memeriksa dan menginstal gnupg jika belum terinstal
    if ! command -v gpg &> /dev/null; then
        echo "gnupg belum terinstal. Menginstal gnupg..."
        sudo apt install -y gnupg
    else
        echo "gnupg sudah terinstal."
    fi

    # 3. Memeriksa keberadaan public GPG key MongoDB, jika sudah ada maka hapus yang lama
    if [ -f "/usr/share/keyrings/mongodb-server-7.0.gpg" ]; then
        echo "File public key GPG MongoDB sudah ada. Menghapus yang lama..."
        sudo rm -f /usr/share/keyrings/mongodb-server-7.0.gpg
    fi

    # 4. Import public GPG key MongoDB dengan cURL dan GnuPG
    curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
    sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor

    # 5. Memeriksa keberadaan repository MongoDB, jika sudah ada maka hapus yang lama
    if [ -f "/etc/apt/sources.list.d/mongodb-org-7.0.list" ]; then
        echo "File repository MongoDB sudah ada. Menghapus yang lama..."
        sudo rm -f /etc/apt/sources.list.d/mongodb-org-7.0.list
    fi

    # 6. Buat daftar repository MongoDB untuk penginstalan
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] \
https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | \
sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

    # 7. Update repository
    sudo apt-get update

    # 8. Instal MongoDB
    sudo apt-get install -y mongodb-org
    sudo systemctl start mongod
    sudo systemctl daemon-reload
    sudo systemctl enable mongod

echo "Instalasi MongoDB selesai."
}

# Fungsi untuk meng-uninstall MongoDB
uninstall_mongodb(){
    echo "Menghapus instalasi MongoDB"

    # 1. Stop MongoDB service
    sudo systemctl stop mongod
    sudo service mongod stop

    # 2. Hapus MongoDB packages
    sudo apt-get purge -y mongodb-org*
    sudo apt-get purge "mongodb-org*"
    # 3. Hapus MongoDB directories
    sudo rm -r /var/log/mongodb
    sudo rm -r /var/lib/mongodb

    # 4. Hapus public GPG key MongoDB
    if [ -f "/usr/share/keyrings/mongodb-server-7.0.gpg" ]; then
        echo "Menghapus public GPG key MongoDB"
        sudo rm -f /usr/share/keyrings/mongodb-server-7.0.gpg
    fi

    # 5. Hapus repository MongoDB
    if [ -f "/etc/apt/sources.list.d/mongodb-org-7.0.list" ]; then
        echo "Menghapus repository MongoDB"
        sudo rm -f /etc/apt/sources.list.d/mongodb-org-7.0.list
    fi

    # 6. Update repository
    sudo apt-get update
    systemctl daemon-reload

    echo "Uninstall MongoDB selesai."
}

# Menampilkan pilihan kepada pengguna
echo "Pilih opsi:"
echo "1. Instal MongoDB"
echo "2. Uninstall MongoDB"
read -p "Masukkan pilihan (1 atau 2): " choice

# Memeriksa pilihan pengguna dan menjalankan fungsi yang sesuai
if [ "$choice" == "1" ]; then
    install_mongodb
elif [ "$choice" == "2" ]; then
    uninstall_mongodb
else
    echo "Pilihan tidak valid. Harap masukkan 1 atau 2."
    exit 1
fi

