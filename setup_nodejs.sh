#!/bin/bash

# Fungsi untuk menginstal Node.js menggunakan NVM
install_nodejs() {
    echo "Memperbarui daftar paket..."
    sudo apt update && upgrade -y

    echo "Memeriksa apakah curl sudah terinstal..."
    if ! command -v curl &> /dev/null; then
        echo "curl belum terinstal. Menginstal curl..."
        sudo apt install -y curl
    else
        echo "curl sudah terinstal."
    fi

    echo "Memeriksa apakah NVM sudah terinstal..."
    if [ -z "$NVM_DIR" ]; then
        echo "Menginstal NVM..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
        # Muat ulang profil shell
        export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    else
        echo "NVM sudah terinstal."
    fi

    echo "Menginstal Node.js versi 18 menggunakan NVM..."
    nvm install 18
    nvm use 18

    # Verifikasi instalasi Node.js dan npm
    node_version=$(node -v)
    npm_version=$(npm -v)

    echo "Node.js version: $node_version"
    echo "npm version: $npm_version"
    echo " NVM dan Node.js  berhasil diinstal "

    # Muat ulang profil shell jika Node.js belum berjalan
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

# Fungsi untuk menguninstal Node.js dan NVM
uninstall_nodejs() {
    echo "Menghapus NVM, Node.js, npm, dan pm2..."

    # Load NVM jika belum diload
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

    # Unload NVM dari shell
    nvm unload

    # Hapus direktori NVM
    rm -rf "$NVM_DIR"

    # Hapus NVM dari file startup shell
    sed -i '/export NVM_DIR/d' ~/.bashrc
    sed -i '/\[ -s "\$NVM_DIR\/nvm.sh" \] && \. "\$NVM_DIR\/nvm.sh"/d' ~/.bashrc
    sed -i '/\[ -s "\$NVM_DIR\/bash_completion" \] && \. "\$NVM_DIR\/bash_completion"/d' ~/.bashrc
    sed -i '/export NVM_DIR/d' ~/.zshrc
    sed -i '/\[ -s "\$NVM_DIR\/nvm.sh" \] && \. "\$NVM_DIR\/nvm.sh"/d' ~/.zshrc
    sed -i '/\[ -s "\$NVM_DIR\/bash_completion" \] && \. "\$NVM_DIR\/bash_completion"/d' ~/.zshrc

    echo "Node.js dan NVM berhasil dihapus."
}

# Menu pilihan untuk pengguna
echo "========== Setup NVM NodeJS npm ========"
echo "Pilih tindakan yang ingin Anda lakukan:"
echo "1. Instal Node.js"
echo "2. Uninstal Node.js "
read -p "Masukkan pilihan Anda (1 atau 2): " pilihan

case $pilihan in
    1)
        install_nodejs
        ;;
    2)
        uninstall_nodejs
        ;;
    *)
        echo "Pilihan tidak valid. Silakan jalankan script lagi dan pilih 1 atau 2."
        ;;
esac

