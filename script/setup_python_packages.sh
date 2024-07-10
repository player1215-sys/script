#!/bin/bash

# Fungsi untuk menginstal paket Python
install_python_packages() {
    echo "Memperbarui daftar paket..."
    sudo apt update

    echo "Menginstal paket python3.12-venv..."
    sudo apt install -y python3.12-venv

    echo "Membuat virtual environment..."
    python3 -m venv myenv

    echo "Mengaktifkan virtual environment..."
    source myenv/bin/activate

    echo "Menginstal paket FastAPI..."
    pip install fastapi==0.111.0

    echo "Menginstal paket SSE-Starlette..."
    pip install sse-starlette==2.1.2

    echo "Menginstal paket Motor..."
    pip install motor==3.5.0

    echo "Menginstal paket Uvicorn..."
    pip install uvicorn==0.30.1

    echo "Menonaktifkan virtual environment..."
    deactivate

    echo "Instalasi paket Python selesai."
}

# Fungsi untuk menguninstal paket Python
uninstall_python_packages() {
    echo "Menonaktifkan virtual environment jika sedang aktif..."
    if [ -n "$VIRTUAL_ENV" ]; then
        deactivate
    fi

    echo "Menghapus virtual environment..."
    rm -rf myenv

    echo "Menghapus paket python3.12-venv jika tidak diperlukan lagi..."
    sudo apt remove --purge -y python3.12-venv

    echo "Membersihkan paket yang tidak diperlukan lagi..."
    sudo apt autoremove -y
    sudo apt clean

    echo "Uninstallasi dan pembersihan selesai."
}

# Menu pilihan untuk pengguna
echo "Packages : Fastapi, SSE-Starlette, Motor, Uvicorn"
echo "Pilih tindakan yang ingin Anda lakukan:"
echo "1. Install packages Python"
echo "2. Uninstall packages Python"
read -p "Masukkan pilihan Anda (1 atau 2): " pilihan

case $pilihan in
    1)
        install_python_packages
        ;;
    2)
        uninstall_python_packages
        ;;
    *)
        echo "Pilihan tidak valid. Silakan jalankan script lagi dan pilih 1 atau 2."
        ;;
esac

