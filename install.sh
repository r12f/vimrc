#!/bin/bash

VIMRC_HOME=$(cd "$(dirname "$0")"; pwd)

echo "Install VIM configuration ..."

function CreateSymbolLinkWithBackup {
    local source_file=$1
    local dest_file=$2

    if [ -e "$dest_file" -o -h "$dest_file" ]; then
        local backup_id=0
        local backup_file="$dest_file.bak"
        while [ -f "$backup_file" -o -h "$backup_file" ]; do
            (( backup_id += 1 ))
            backup_file="$dest_file.${backup_id}.bak"
        done

        echo "Backing up \"$dest_file\" to \"$backup_file\" ..."
        if ! mv "$dest_file" "$backup_file"; then
            echo "Create backup failed."
            return 1
        fi
    fi

    echo "Creating symbol link: \"$dest_file\" -> \"$source_file\""
    if ! ln -s "$source_file" "$dest_file"; then
        echo "Creating symbol link failed."
        return 1
    fi

    return 0
}

echo "Updating system VIM configuration ..."
if ! CreateSymbolLinkWithBackup "$VIMRC_HOME" "$HOME/.vim"; then
    echo "Install failed."
    exit 1
fi

if ! CreateSymbolLinkWithBackup "$VIMRC_HOME/vimrc" "$HOME/.vimrc"; then
    echo "Install failed."
    exit 1
fi

# Install Plugins
echo "Install VIM plugins ..."
vim -c ":PluginInstall" -c ":qall"

echo "VIM configuration install complete!"
