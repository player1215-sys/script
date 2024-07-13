#!/bin/bash

# Download dan ekstrak runner

echo "Downloading GitHub Actions Runner..."
mkdir actions-runner && cd actions-runner
curl -O -L https://github.com/actions/runner/releases/download/v2.283.3/actions-runner-linux-x64-2.283.3.tar.gz
tar xzf ./actions-runner-linux-x64-2.283.3.tar.gz

# Konfigurasi runner
echo "Configuring GitHub Actions Runner..."

#./config.sh --url https://github.com/{owner}/{repo} --token {token}

# Ganti {owner}/{repo} dengan nama pemilik dan repositori GitHub Anda
# Ganti {token} dengan personal access token yang memiliki akses ke repositori Anda

# Jalankan runner
echo "Starting GitHub Actions Runner..."

#./run.sh
