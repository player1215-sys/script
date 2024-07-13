#!/bin/bash

# Fungsi untuk menginstal GitHub Actions Runner
install_runner() {
    echo "Downloading GitHub Actions Runner..."
    mkdir -p actions-runner && cd actions-runner
    #curl -O -L https://github.com/actions/runner/releases/download/v2.283.3/actions-runner-linux-x64-2.283.3.tar.gz
    #tar xzf ./actions-runner-linux-x64-2.283.3.tar.gz

    # Konfigurasi runner
    echo "Configuring GitHub Actions Runner..."
    #./config.sh --url https://github.com/{owner}/{repo} --token {token}
    # Ganti {owner}/{repo} dengan nama pemilik dan repositori GitHub Anda
    # Ganti {token} dengan personal access token yang memiliki akses ke repositori Anda

    # Jalankan runner
    echo "Starting GitHub Actions Runner..."
    #./run.sh
}

# Fungsi untuk menghapus GitHub Actions Runner
uninstall_runner() {
    echo "Stopping GitHub Actions Runner..."
    ./svc.sh stop
    ./config.sh remove --token {token}
    # Ganti {token} dengan personal access token yang digunakan saat konfigurasi runner

    echo "Deleting GitHub Actions Runner..."
    cd ~
    rm -rf actions-runner

    echo "Uninstallation and cleanup complete."
}

# Menu pilihan untuk pengguna
echo "Pilih opsi:"
echo "1. Install GitHub Actions Runner"
echo "2. Uninstall GitHub Actions Runner"
read -p "Masukkan pilihan Anda (1 atau 2): " choice

case $choice in
    1)
        install_runner
        ;;
    2)
        uninstall_runner
        ;;
    *)
        echo "Pilihan tidak valid. Silakan masukkan 1 atau 2."
        ;;
esac
