#!/bin/bash

# Ensure script stops on error
set -e

echo "Starting deep clean..."

# 1. Homebrew Binary-Only Maintenance
# Forces use of binaries to avoid multi-gigabyte build toolchains (LLVM/Rust)
if command -v brew >/dev/null; then
    echo "Cleaning Homebrew..."
    export HOMEBREW_NO_BUILD_FROM_SOURCE=1
    brew update
    brew upgrade
    brew autoremove
    brew cleanup --prune=all
    rm -rf $(brew --cache)
fi

# 2. Microsoft & Remote Desktop Purge
# Targets the 176MB+ HxStore.hxd and Office containers
echo "Purging Microsoft containers..."
pkill -f "Microsoft" || true
rm -rf ~/Library/Group\ Containers/UBF8T346G9.*
rm -rf ~/Library/Containers/com.microsoft.rdc.macos
rm -rf ~/Library/Application\ Support/Microsoft*

# 3. Developer & AI Cache Clearing
# Cleans uv (Python) and Ollama (AI) blobs found in search
echo "Clearing developer caches..."
[[ -d ~/.ollama/models/blobs ]] && rm -rf ~/.ollama/models/blobs/*
[[ -d ~/.cache/uv ]] && rm -rf ~/.cache/uv/*
command -v npm >/dev/null && npm cache clean --force

# 4. Xcode & Mobile Device Support
# Essential for reclaiming 5GB+ after system updates
if [ -d ~/Library/Developer/Xcode ]; then
    echo "Cleaning Xcode artifacts..."
    rm -rf ~/Library/Developer/Xcode/DerivedData/*
    rm -rf ~/Library/Developer/Xcode/iOS\ DeviceSupport/*
    xcrun simctl delete unavailable 2>/dev/null || true
fi

# 5. System & Browser Bloat
echo "Clearing system caches..."
# Reset Spotlight index to fix massive index files
sudo mdutil -E / >/dev/null
# Target YouTube/Grafana IndexedDB bloat in Firefox
rm -rf ~/Library/Application\ Support/Firefox/Profiles/*.default-release/storage/default/https+++www.youtube.com*

# 6. Reclaim "Ghost" Space
# Forces macOS to realize space from deleted files locked in snapshots
echo "Thinning local snapshots..."
sudo tmutil thinlocalsnapshots / 1000000000 1

echo "--- Clean Complete ---"
df -h / | grep Filesystem -A 1
