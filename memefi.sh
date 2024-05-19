#!/bin/bash

echo "Loading Bree...."
wget -O loading.sh https://raw.githubusercontent.com/Semutireng22/saya/main/loading.sh && chmod +x loading.sh && ./loading.sh
sleep 2

echo "Masukan API_ID (Ambil dari https://my.telegram.org/auth?to=apps):"
read API_ID
echo "Masukan API_HASH (Ambil dari https://my.telegram.org/auth?to=apps):"
read API_HASH

if [ -d "MemeFiBot" ]; then
    echo "Menghapus folder MemeFiBot yang sudah ada..."
    rm -rf TapSwapBot || { echo "Gagal menghapus folder MemeFiBot yang sudah ada."; exit 1; }
fi

echo "Proses Kloning MemeFiBot..."
git clone https://github.com/shamhi/MemeFiBot.git || { echo "Gagal untuk mengkloning repo."; exit 1; }
cd MemeFiBot || { echo "Gagal mengubah folder."; exit 1; }

echo "Mengatur virtual environment..."
echo "Memasang paket Python 3.10 dan necessary..."
sudo apt update
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt update
sudo apt install python3.10 python3.10-venv python3.10-dev -y || { echo "Gagal emasang paket Python 3.10 dan necessary."; exit 1; }

python3.10 -m venv venv || { echo "Gagal membuat virtual environment."; exit 1; }
source venv/bin/activate || { echo "Gagal mengaktifkan virtual environment."; exit 1; }

echo "Memasang paket yang dibutuhkan..."
pip install --upgrade pip
pip install wheel
pip install -r requirements.txt || { echo "Gagal memasang paket yang dibutuhkan."; exit 1; }

echo "Ganti nama file .env-example ke .env ..."
cp .env-example .env || { echo "Gagal menyalin .env-example ke .env."; exit 1; }

sed -i "s/^API_ID=.*/API_ID=$API_ID/" .env
sed -i "s/^API_HASH=.*/API_HASH=$API_HASH/" .env

echo "Kamu dapat mengedit konfigurasi bot di file .env"
echo "Berhasil memasang."
