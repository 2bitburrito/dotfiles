#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

sudo mkdir -p /Library/Logs/Kanata

sudo install -m 644 "$SCRIPT_DIR/com.hugh.kanata.plist" /Library/LaunchDaemons/com.hugh.kanata.plist
sudo install -m 644 "$SCRIPT_DIR/com.hugh.karabiner-vhiddaemon.plist" /Library/LaunchDaemons/com.hugh.karabiner-vhiddaemon.plist
sudo install -m 644 "$SCRIPT_DIR/com.hugh.karabiner-vhidmanager.plist" /Library/LaunchDaemons/com.hugh.karabiner-vhidmanager.plist

sudo launchctl bootout system/com.hugh.kanata >/dev/null 2>&1 || true
sudo launchctl bootout system/com.hugh.karabiner-vhiddaemon >/dev/null 2>&1 || true
sudo launchctl bootout system/com.hugh.karabiner-vhidmanager >/dev/null 2>&1 || true

sudo launchctl bootstrap system /Library/LaunchDaemons/com.hugh.karabiner-vhiddaemon.plist
sudo launchctl bootstrap system /Library/LaunchDaemons/com.hugh.karabiner-vhidmanager.plist
sudo launchctl bootstrap system /Library/LaunchDaemons/com.hugh.kanata.plist

sudo launchctl enable system/com.hugh.karabiner-vhiddaemon
sudo launchctl enable system/com.hugh.karabiner-vhidmanager
sudo launchctl enable system/com.hugh.kanata

sudo launchctl kickstart -k system/com.hugh.karabiner-vhiddaemon
sudo launchctl kickstart -k system/com.hugh.karabiner-vhidmanager
sudo launchctl kickstart -k system/com.hugh.kanata

sudo launchctl print system/com.hugh.kanata | rg "state =|path =|last exit code"
