#!/bin/sh

case "$1" in
    status)
        STATE=$(lipc-get-prop com.lab126.powerd preventScreenSaver 2>/dev/null)
        if [ "$STATE" = "1" ]; then
            eips 0 37 "Screensaver: DISABLED (staying awake)"
        else
            eips 0 37 "Screensaver: ENABLED (can sleep)"
        fi
        ;;
    off)
        lipc-set-prop com.lab126.powerd preventScreenSaver 1
        eips 0 37 "Screensaver DISABLED (staying awake)"
        ;;
    on)
        lipc-set-prop com.lab126.powerd preventScreenSaver 0
        eips 0 37 "Screensaver ENABLED (can sleep)"
        ;;
esac
