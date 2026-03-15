#!/bin/sh

PIDFILE="/var/run/rtcloop.pid"
RTC="/sys/devices/platform/mxc_rtc.0/wakeup_enable"

start_loop() {
    SLEEP_DURATION=$1
    INITIAL_DELAY=${2:-60}
    WAKE_DELAY=${3:-30}

    if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
        eips 0 37 "RTC Loop already running (PID $(cat "$PIDFILE"))"
        return
    fi

    rm -f "$PIDFILE"

    echo powersave > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    lipc-set-prop com.lab126.powerd preventScreenSaver 1

    (
        sleep "$INITIAL_DELAY"

        while true; do
            BATT=$(gasgauge-info -c | sed 's/%/%%/')
            eips 1 3 " ${BATT} "
            sleep 1
            [ "$(cat "$RTC")" -eq 0 ] && echo -n "$SLEEP_DURATION" > "$RTC"
            echo "mem" > /sys/power/state

            sleep "$WAKE_DELAY"
        done
    ) &

    echo "$!" > "$PIDFILE"
    eips 0 37 "RTC Loop started: ${SLEEP_DURATION}s sleep, ${INITIAL_DELAY}s init, ${WAKE_DELAY}s wake"
}

stop_loop() {
    if [ -f "$PIDFILE" ]; then
        PID=$(cat "$PIDFILE")
        if kill -0 "$PID" 2>/dev/null; then
            kill "$PID"
            rm -f "$PIDFILE"
            echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
            lipc-set-prop com.lab126.powerd preventScreenSaver 0
            eips 0 37 "RTC Loop stopped"
        else
            rm -f "$PIDFILE"
            eips 0 37 "RTC Loop was not running"
        fi
    else
        eips 0 37 "RTC Loop is not running"
    fi
}

show_status() {
    if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
        eips 0 37 "RTC Loop: RUNNING (PID $(cat "$PIDFILE"))"
    else
        eips 0 37 "RTC Loop: NOT RUNNING"
    fi
}

case "$1" in
    start)
        shift
        start_loop "$@"
        ;;
    stop)
        stop_loop
        ;;
    status)
        show_status
        ;;
esac
