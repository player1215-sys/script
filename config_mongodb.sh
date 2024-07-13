#!/bin/bash

# Fungsi untuk mengkonfigurasi MongoDB agar dapat diakses dari luar
configure_mongodb_remote_access() {
    echo "Mengkonfigurasi MongoDB untuk akses jarak jauh..."

    # Backup file konfigurasi MongoDB
    # sudo cp /etc/mongod.conf /etc/mongod.conf.backup

    # Ubah bindIp di file konfigurasi ubah (0.0.0.0) dengan ip host/server
    sudo sed -i 's/bindIp: .*/bindIp: 127.0.0.1,0.0.0.0/' /etc/mongod.conf

    # Restart MongoDB untuk menerapkan perubahan
    sudo systemctl restart mongod
    # Mengizinkan atau mengaktifkan port 27017
    sudo ufw allow 27017/tcp
    sudo ufw reload
    # konvirmasi
    echo "MongoDB telah dikonfigurasi untuk akses jarak jauh."
    # mongosh --host <ip host> --port 27017

}

# Fungsi untuk membuat pengguna admin di MongoDB
create_mongodb_admin_user() {
    echo "Membuat pengguna admin di MongoDB..."

    # Meminta input username dan password dari pengguna
    read -p "Masukkan username admin: " username
    read -s -p "Masukkan password admin: " password
    echo

    # Menjalankan perintah MongoDB untuk membuat pengguna admin
    mongosh <<EOF
use admin
db.createUser({
  user: "$username",
  pwd: "$password",
  roles: [{ role: "userAdminAnyDatabase", db: "admin" }]
})
EOF

    echo "Pengguna admin telah dibuat dengan username '$username'."
    systemctl restart mongod

}

# Fungsi untuk masuk ke terminal MongoDB
connect_to_mongodb() {
    HOST="0.0.0.0" # masukkan ip host / server
    PORT="27017"
   #USER="remote_user"  # Ganti dengan nama pengguna MongoDB Anda
   #PASSWORD="secure_password"  # Ganti dengan password MongoDB Anda
   #AUTH_DB="admin"  # Ganti dengan database otentikasi MongoDB Anda

    echo "Menghubungkan ke MongoDB di $HOST:$PORT..."

    mongosh --host $HOST --port $PORT
   #mongosh --host $HOST --port $PORT -u $USER -p $PASSWORD --authenticationDatabase $AUTH_DB
}

# Menampilkan pilihan kepada pengguna
echo "Pilih opsi:"
echo "1) Konfigurasi MongoDB untuk akses jarak jauh"
echo "2) Buat pengguna admin MongoDB"
echo "3) Connect to mongodb"
read -p "Masukkan pilihan (1,2 atau 3): " choice

# Memproses pilihan pengguna dengan konfirmasi
case $choice in
    1)
        read -p "Anda memilih untuk mengkonfigurasi MongoDB untuk akses jarak jauh. Apakah Anda yakin? (y/n): " confirm
        if [ "$confirm" == "y" ]; then
            configure_mongodb_remote_access
        else
            echo "Konfigurasi dibatalkan."
        fi
        ;;
    2)
        read -p "Anda memilih untuk membuat pengguna admin MongoDB. Apakah Anda yakin? (y/n): " confirm
        if [ "$confirm" == "y" ]; then
            create_mongodb_admin_user
        else
            echo "Pembuatan pengguna dibatalkan."
        fi
        ;;
    3)
        read -p "Anda memilih untuk terhubung ke MongoDB. Apakah Anda yakin? (y/n): " confirm
        if [ "$confirm" == "y" ]; then
            connect_to_mongodb
        else
            echo "Konvirmasi dibatalkan."
        fi
        ;;
    *)
        echo "Pilihan tidak valid. Harap masukkan 1, 2, atau 3."
        exit 1
        ;;
esac

exit 0



