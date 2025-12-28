#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
DOTFILES_DIR="$SCRIPT_DIR"   # copy INTO this directory
#"~/.config/nvim"

DOTFILES=(
    "~/.config/i3"
    "~/.zshrc"
    "~/.vimrc"
    "~/.config/dunst"
    "~/bin/i3-battery-warning"
    "~/.config/nvim"
    "~/.config/hypr"
    "~/.config/kitty"
    "~/.config/flameshot"
    "~/.config/Code/User/settings.json"
    "~/.config/Code/User/keybindings.json"
    "~/.config/Code/User/profiles/"
)

GIT_MODE=false
if [[ "${1:-}" == "git" ]]; then
    GIT_MODE=true
fi

for item in "${DOTFILES[@]}"; do
    expanded_item=$(eval echo "$item")

    if [[ ! -e "$expanded_item" ]]; then
        echo "- File doesn't exist: $expanded_item"
        continue
    fi

    # Everything after $HOME/ (e.g. ".config/i3" or ".zshrc")
#    rel_path="${expanded_item/#$HOME\//}"

    # Full destination inside dotfiles/
 #   dest="$DOTFILES_DIR/sync/$rel_path"

  #  mkdir -p "$(dirname "$dest")"
   # cp -r "$expanded_item" "$dest"
    rel_path="${expanded_item/#$HOME\//}"

    # parent directory of destination
    dest_dir="$DOTFILES_DIR/sync/$(dirname "$rel_path")"
    mkdir -p "$dest_dir"

    # full final location
    name=$(basename "$expanded_item")

    cp -r "$expanded_item" "$dest_dir/$name"

    echo "+ Synced: $rel_path"
done

if command -v git &>/dev/null; then
    cd "$DOTFILES_DIR" || exit 1

    # Get the list of changed files
    changed_files=$(git diff --name-only)

    if [[ -n "$changed_files" ]]; then
        echo "[INFO] Files changed:"
        echo "$changed_files"
    else
        echo "[INFO] No changes detected."
    fi
fi

if [[ "$GIT_MODE" == true ]]; then
    cd "$DOTFILES_DIR"
    git add .
    git commit -m "sync dotfiles: $(date +'%Y-%m-%d %H:%M:%S')" || echo "No changes to commit"
    git push
    echo "[INFO] Changes committed and pushed to git"
fi
