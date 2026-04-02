#!/usr/bin/env bash

# reference_path="/etc/shadow-"
# start_date=$(date -r "$reference_path" +%s)

reference_path="/var/guix/profiles/system-1-link"
start_date=$(date -d "@$(stat -c %Y "$reference_path")" +%s)

# Get current date in seconds
today=$(date +%s)

# Calculate duration in seconds
duration_seconds=$(( today - start_date ))

# Calculate duration in days (Bash arithmetic does integer division/floor by default)
duration_days=$(( duration_seconds / 86400 ))

printf "%s" "$duration_days"
