
#!/bin/bash
# Generate calendar grid in eww format

year=$(date +%Y)
month=$(date +%m)
today=$(date +%d)

# Get first day of month and number of days
first_day=$(date -d "$year-$month-01" +%u)
[ "$first_day" = "7" ] && first_day=0
days_in_month=$(date -d "$year-$month-01 +1 month -1 day" +%d)

# Get previous month's days
prev_month=$(date -d "$year-$month-01 -1 day" +%m)
prev_year=$(date -d "$year-$month-01 -1 day" +%Y)
days_in_prev_month=$(date -d "$prev_year-$prev_month-01 +1 month -1 day" +%d)

# Start building the calendar
echo "(box :class \"cal-grid\" :orientation \"v\" :space-evenly false"

day=1
prev_day=$((days_in_prev_month - first_day + 1))
next_day=1
week=0

while [ $day -le $days_in_month ] || [ $week -eq 0 ]; do
    echo "  (box :class \"cal-row\" :orientation \"h\""
    
    for dow in 0 1 2 3 4 5 6; do
        if [ $week -eq 0 ] && [ $dow -lt $first_day ]; then
            echo "    (label :class \"cal-day other-month\" :text \"$prev_day\")"
            prev_day=$((prev_day + 1))
        elif [ $day -le $days_in_month ]; then
            class="cal-day"
            [ $day -eq $today ] && class="cal-day today"
            echo "    (label :class \"$class\" :text \"$day\")"
            day=$((day + 1))
        else
            echo "    (label :class \"cal-day other-month\" :text \"$next_day\")"
            next_day=$((next_day + 1))
        fi
    done
    
    echo "  )"
    week=$((week + 1))
    
    # Break if we've shown all days and filled the last week
    [ $day -gt $days_in_month ] && [ $dow -eq 6 ] && break
done

echo ")"

