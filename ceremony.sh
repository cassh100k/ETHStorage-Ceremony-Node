#!/usr/bin/env bash
set -euo pipefail

# This guide does NOT install phase2cli for you.
# Install it from the OFFICIAL EthStorage instructions first.

if ! command -v phase2cli >/dev/null 2>&1; then
  echo "[ERROR] phase2cli not found. Install it from the official EthStorage docs, then retry."
  exit 1
fi

echo "[*] Login (safe to re-run if already authenticated)…"
phase2cli login || true

echo "[*] Start contribution…"
phase2cli contribute

echo "[*] Done."

Make them executable (optional but nice):
chmod +x advanced.sh ceremony.sh
