#!/usr/bin/env fish

set reference_path /etc/shadow-

set start_date (date -r $reference_path +%s)

set today (date +%s)

set duration_seconds (math "$today - $start_date")

set duration_days (math "floor($duration_seconds / 86400)")

if test (math "abs($duration_days)") -eq 1
    set age_string "$duration_days day"
else
    set age_string "$duration_days days"
end

printf "%s" $age_string
