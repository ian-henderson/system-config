#!/bin/bash

start_date=$(date -d "4/27/2025 17:30" +%s)
today=$(date +%s)
duration_seconds=$((today - start_date))
duration_days=$((duration_seconds / 86400))

if [[ "$duration_days" -eq 1 ]]; then
	age_string="$duration_days day"
else
	age_string="$duration_days days"
fi

echo -n "$age_string"
