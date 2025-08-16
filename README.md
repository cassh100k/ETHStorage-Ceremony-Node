# ETHStorage-Ceremony-Node
🌟A modular and decentralized storage Layer 2 that offers programmable key-value storage 🌟Scaling Storage of the World Computer 🌟Received grants from ESP

# 🌟 EthStorage V1 Trusted Setup Ceremony Walkthrough

A simple guide to join the EthStorage Trusted Setup Ceremony.

---

## 🛠️ Prerequisites
- Ubuntu 22.04 VPS (2 vCPU, 4 GB RAM, 30 GB+ SSD)
- SSH access
- GitHub account (≥ 1 month old; ≥ 1 public repo; following ≥ 5 users; ≥ 1 follower)
- **phase2cli** installed from the **official EthStorage docs** (this guide does not install it)

---

## ⚡ Quick Install (one-liner)
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/cassh100k/ETHStorage-Ceremony-Node/main/advanced.sh)

## 🔑 Authentication

When you start the ceremony tool, it will show a **GitHub login URL** and a **code**.

1) **Open the URL** in any browser.  
2) **Sign in to GitHub** (use the account you want to credit).  
3) **Paste the code** back into the terminal when asked.  
4) If asked to confirm permissions, choose **Yes**.

> Tip: If you already logged in previously, the tool may say you're already authenticated. That's fine—continue.

## 🎲 Contribution

After authentication, the tool will ask about **random/manual** entropy.  
- Press **Enter** for the default (random), unless official docs tell you otherwise.

Then it starts your contribution automatically and shows progress in the terminal.


## 📉 Logs

If you used the one-liner installer, a systemd service named `ceremony` runs the script:

```bash
journalctl -u ceremony -f


---

## 4) Add the **Cleanup** section

```md
## 🧹 Cleanup

After your contribution finishes, you can tidy up:

```bash
phase2cli clean
phase2cli logout
cd ~ && rm -rf ~/trusted-setup-tmp

# If you used the service installer:
sudo systemctl stop ceremony && sudo systemctl disable ceremony \
  && sudo rm -f /etc/systemd/system/ceremony.service \
  && sudo systemctl daemon-reload && sudo systemctl reset-failed


---

## 5) Add the two helper scripts (if you haven’t yet)

In Codespaces, create these two files in your repo root.

### `advanced.sh`
```bash
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
