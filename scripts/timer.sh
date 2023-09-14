#!/bin/bash

work_duration=25
break_duration=5
long_break_duration=15
sessions_until_long_break=4
work_sessions=0

format_time() {
    local seconds=$1
    local minutes=$((seconds / 60))
    local seconds=$((seconds % 60))
    printf "%02d:%02d" "$minutes" "$seconds"
}

while true; do
    echo "Work session $((work_sessions + 1)): Focus on your work for $work_duration minutes!"
    remaining=$((work_duration * 60))
    
    while [ $remaining -gt 0 ]; do
        echo -ne "Time left: $(format_time $remaining)\033[0K\r"
        sleep 1
        remaining=$((remaining - 1))
    done

    work_sessions=$((work_sessions + 1))

    if ((work_sessions % sessions_until_long_break == 0)); then
        echo -e "\nLong break: Take a break for $long_break_duration minutes!"
        remaining=$((long_break_duration * 60))
    else
        echo -e "\nShort break: Take a break for $break_duration minutes!"
        remaining=$((break_duration * 60))
    fi

    while [ $remaining -gt 0 ]; do
        echo -ne "Time left: $(format_time $remaining)\033[0K\r"
        sleep 1
        remaining=$((remaining - 1))
    done
done

