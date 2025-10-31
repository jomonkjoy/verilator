#!/bin/bash

# Verilator Installation Script for Ubuntu Linux
# This script installs Verilator from source

set -e  # Exit on any error

echo "==================================="
echo "Verilator Installation Script"
echo "==================================="

# Update package list
echo "Updating package list..."
sudo apt-get update

# Install dependencies
echo "Installing dependencies..."
sudo apt-get install git help2man perl python3 make
sudo apt-get install g++  # Alternatively, clang
#sudo apt-get install libgz  # Non-Ubuntu (ignore if gives error)
sudo apt-get install libfl2  # Ubuntu only (ignore if gives error)
sudo apt-get install libfl-dev  # Ubuntu only (ignore if gives error)
sudo apt-get install zlibc zlib1g zlib1g-dev  # Ubuntu only (ignore if gives error)
sudo apt-get install libsystemc libsystemc-dev
sudo apt-get install z3  # Optional solver
sudo apt-get install perl-doc
sudo apt-get install ccache  # If present at build, needed for run
sudo apt-get install mold  # If present at build, needed for run
sudo apt-get install libgoogle-perftools-dev numactl
sudo apt-get install git autoconf flex bison
sudo apt-get install gtkwave  # Optional Waveform viewer

# Set Verilator version (change this to install a different version)
VERILATOR_VERSION="v5.028"

# Clone Verilator repository
echo "Cloning Verilator repository..."
cd /tmp
if [ -d "verilator" ]; then
    echo "Removing existing verilator directory..."
    rm -rf verilator
fi

git clone https://github.com/verilator/verilator
cd verilator
git pull        # Make sure we're up-to-date
git tag         # See what versions exist
#git checkout master      # Use development branch (e.g. recent bug fix)
#git checkout stable      # Use most recent release
#git checkout v{version}  # Switch to specified release version

# Checkout specific version
echo "Checking out version ${VERILATOR_VERSION}..."
git checkout ${VERILATOR_VERSION}

# Build and install
echo "Building Verilator..."
autoconf
./configure

echo "Compiling (this may take several minutes)..."
make -j$(nproc)
make test
echo "Installing Verilator..."
sudo make install

# Verify installation
echo ""
echo "==================================="
echo "Installation complete!"
echo "==================================="
verilator --version

echo ""
echo "Verilator has been successfully installed!"
echo "You can now use 'verilator' command from anywhere."
