#!/usr/bin/env bash

manual_date="2026-01-20 12:00"

# Convert to seconds
start_date=$(date -d "$manual_date" +%s)
today=$(date +%s)

# Calculate total seconds difference
diff=$(( today - start_date ))

# Handle future dates (Absolute Value)
if [ "$diff" -lt 0 ]; then
    diff=$(( diff * -1 ))
fi

days=$(( diff / 86400 ))
hours=$(( (diff % 86400) / 3600 ))
minutes=$(( (diff % 3600) / 60 ))

pluralize() {
    local count=$1
    local word=$2
    if [ "$count" -eq 1 ]; then
        printf "%d %s" "$count" "$word"
    else
        printf "%d %ss" "$count" "$word"
    fi
}

# Build the output string
result="$(pluralize "$days" "day"), $(pluralize "$hours" "hour"), $(pluralize "$minutes" "minute")"

echo "$result"
