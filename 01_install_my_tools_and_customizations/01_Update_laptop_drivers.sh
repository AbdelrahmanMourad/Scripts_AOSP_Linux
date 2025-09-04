#!/bin/bash
# =====================================================================
# update_drivers_and_test_cuda.sh
# Purpose:
#   - Update Ubuntu system + drivers (NVIDIA and others)
#   - Install CUDA toolkit
#   - Compile & run CUDA sample (deviceQuery) to confirm GPU compute
# =====================================================================

# -------------------------------
# SECTION 1: System Update
# -------------------------------
echo "=== [1/4] Updating system packages ==="
sudo apt update -y          # Refresh package index
sudo apt full-upgrade -y    # Upgrade all installed packages to latest versions
sudo apt autoremove -y      # Remove old/unused packages

# -------------------------------
# SECTION 2: NVIDIA Driver Update
# -------------------------------
echo "=== [2/4] Updating NVIDIA drivers ==="
# Detect & install recommended NVIDIA driver for your GPU
sudo ubuntu-drivers autoinstall

# Reinstall explicitly in case something is half-installed
sudo apt install --reinstall nvidia-driver-535 -y

# Verify driver after install
echo "[INFO] Checking NVIDIA driver with nvidia-smi..."
if command -v nvidia-smi &>/dev/null; then
    nvidia-smi
else
    echo "[ERROR] nvidia-smi not found. NVIDIA driver may not be installed correctly."
fi

# -------------------------------
# SECTION 3: Install CUDA Toolkit
# -------------------------------
echo "=== [3/4] Installing CUDA toolkit ==="
sudo apt install -y nvidia-cuda-toolkit

# Verify CUDA compiler
if command -v nvcc &>/dev/null; then
    echo "[INFO] CUDA compiler version:"
    nvcc --version
else
    echo "[WARNING] nvcc not found. CUDA toolkit may not be installed correctly."
fi

# -------------------------------
# SECTION 4: Test CUDA with deviceQuery
# -------------------------------
echo "=== [4/4] Compiling and running CUDA deviceQuery sample ==="

# Copy CUDA samples into home directory (safe to modify there)
CUDA_SAMPLES_DIR=~/cuda-samples
mkdir -p "$CUDA_SAMPLES_DIR"
cp -r /usr/share/doc/nvidia-cuda-toolkit/examples/* "$CUDA_SAMPLES_DIR" 2>/dev/null || true

# Build the deviceQuery sample
cd "$CUDA_SAMPLES_DIR/4_Finance/deviceQuery" || { echo "[ERROR] deviceQuery path not found"; exit 1; }
make clean && make

# Run the test
echo "[INFO] Running CUDA deviceQuery..."
./deviceQuery

echo "=== Script completed! Check above for 'Result = PASS' to confirm CUDA works ==="
