#!/usr/bin/env bash

echo "SYNCHRONIZING GUIX"

if ! [ -f "$HOME/.config/guix/channels.scm" ]; then
	echo "Error: channels.scm is missing. Run sync_configs.sh before running this script."
	exit 1
fi

SYSTEM_CONFIG="$HOME/Developer/system-config"

guix package -m "$SYTEM_CONFIG/guix.d/user-profile-manifest.scm"

echo "/etc/config.scm should be handled manually. Copy guix.d/config.scm to /etc/config.scm after adding unique uuid values to the script."
