#!/usr/bin/env bash
set -euo pipefail

#echo "hello I am the test script"

DOTFILES_DIR="$(dirname "$(realpath "$0")")"
#echo $DOTFILES_DIR

DOTFILES=(
    ~/.vimrc
    ~/.config/nvim
    ~/.zshrc
    ~/.config/kglobalshortcutsrc
    ~/.config/i3
    ~/.config/hypr
    ~/.config/yazi/
    ~/.config/Code/User/keybindings.json
    ~/.config/Code/User/settings.json
    ~/.config/Code/User/profiles/
    ~/.config/dunst
    ~/.config/kitty
    ~/.config/flameshot
)


#echo $DOTFILES

sync_dir="$DOTFILES_DIR/sync/"
mkdir -p "$sync_dir"

for dir_to_sync in "${DOTFILES[@]}"; do

    if [[ ! -e "$dir_to_sync" ]]; then
        echo "- Directory does not exist: $dir_to_sync"
        continue
    fi

    
    # find all files in dir with find command
    # then copy them 1 by one into syncdir using the cp command
      # Resolve absolute path and strip leading /

    # dest_base="$sync_dir/$dir_to_sync"
    #echo "dest_base $dest_base" 
    # mkdir -p "$(dirname "$dest_base")"
    #echo "mkdir -p '$(dirname "$dest_base')'"

    if [[ -f "$dir_to_sync" ]]; then
        # Strip home directory prefix
        file_rel="${dir_to_sync/#$HOME\//}"
        dest="$sync_dir/$file_rel"

        mkdir -p "$(dirname "$dest")"
        cp -p "$dir_to_sync" "$dest"
        #echo "+ Copied file: $dir_to_sync"
    else
        find "$dir_to_sync" -type f | while IFS= read -r file; do
            file_real="$(realpath "$file")"
            # Strip the home directory prefix
            file_rel="${file_real/#$HOME\//}"
            dest="$sync_dir/$file_rel"
            mkdir -p "$(dirname "$dest")"
            cp -p "$file_real" "$dest"
            echo "+ Copied file: $file_real to $dest"
        done
    fi
done




GIT_MODE=false
if [[ "${1:-}" == "git" ]]; then
    GIT_MODE=true
fi



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
    # Stage changes
    git add .
    # Commit changes if any, capture the result
    if git commit -m "sync" 2>/dev/null; then
        # Only push if commit was successful (there were changes)
        git push
        echo "[INFO] Changes committed and pushed to git"
    else
        echo "[INFO] No changes to commit, nothing pushed"
    fi
fi
