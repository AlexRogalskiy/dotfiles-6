#! /bin/bash
set -euo pipefail

echo "roboll	ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/roboll
apt-get update && apt-get install -y curl
