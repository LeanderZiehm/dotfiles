#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
DOTFILES_DIR="$SCRIPT_DIR"   # copy INTO this directory

DOTFILES=(
    "~/.config/i3"
    "~/.config/nvim"
    "~/.zshrc"
)

#echo "[INFO] Sync started"
#echo "[INFO] Target directory: $DOTFILES_DIR"

for item in "${DOTFILES[@]}"; do
    expanded_item=$(eval echo "$item")

    if [[ ! -e "$expanded_item" ]]; then
        echo "- File doesn't exist: $expanded_item"
        continue
    fi

    # Everything after $HOME/ (e.g. ".config/i3" or ".zshrc")
    rel_path="${expanded_item/#$HOME\//}"

    # Full destination inside dotfiles/
    dest="$DOTFILES_DIR/sync/$rel_path"

    #echo "[INFO] Copying $expanded_item → $dest"

    mkdir -p "$(dirname "$dest")"
    cp -r "$expanded_item" "$dest"

    echo "+ Synced: $rel_path"
done

#echo "[INFO] Sync complete"
