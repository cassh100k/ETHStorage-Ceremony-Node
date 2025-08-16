#!/usr/bin/env bash
set -euo pipefail

if ! command -v phase2cli >/dev/null 2>&1; then
  echo "[ERROR] phase2cli not found. Please install it from the official EthStorage docs."
  exit 1
fi

echo "[*] Logging in (safe to re-run if already authenticated)…"
phase2cli login || true

echo "[*] Starting contribution…"
phase2cli contribute

echo "[*] Done."
