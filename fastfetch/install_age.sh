#!/usr/bin/env bash

reference_path="/etc/shadow-"

# Get start date in seconds (macOS/BSD date might require different flags,
# but this works on Debian/Standard Linux)
start_date=$(date -r "$reference_path" +%s)

# Get current date in seconds
today=$(date +%s)

# Calculate duration in seconds
duration_seconds=$(( today - start_date ))

# Calculate duration in days (Bash arithmetic does integer division/floor by default)
duration_days=$(( duration_seconds / 86400 ))

printf "%s" "$duration_days"
