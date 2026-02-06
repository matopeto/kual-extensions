#!/bin/sh

GOVERNOR_PATH="/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"

case "$1" in
    ondemand|powersave|performance|conservative)
        echo "$1" > "$GOVERNOR_PATH"
        eips 0 37 "CPU Governor set to: $1"
        ;;
esac
