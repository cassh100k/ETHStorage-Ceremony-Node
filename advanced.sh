#!/usr/bin/env bash
set -euo pipefail

RAW_BASE="https://raw.githubusercontent.com/cassh100k/ETHStorage-Ceremony-Node/main"

# 1) deps
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update -y
sudo apt-get install -y --no-install-recommends curl jq git ca-certificates systemd

# 2) runner script
sudo curl -fsSL "$RAW_BASE/ceremony.sh" -o /usr/local/bin/ceremony.sh
sudo chmod +x /usr/local/bin/ceremony.sh

# 3) systemd unit
sudo bash -c 'cat >/etc/systemd/system/ceremony.service <<SERVICE
[Unit]
Description=EthStorage Ceremony
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
ExecStart=/usr/local/bin/ceremony.sh
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
SERVICE'

sudo systemctl daemon-reload
sudo systemctl enable --now ceremony || true

echo "✅ Installed. Logs:  journalctl -u ceremony -f"
echo "⚠️ If you have NOT installed phase2cli yet, the service will fail until you do so from official docs."
