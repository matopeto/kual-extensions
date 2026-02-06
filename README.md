# KUAL Extensions for Kindle 4 NT

Custom KUAL extensions for Kindle 4 Non-Touch.

## Disclaimer

These extensions were tested on Kindle 4 NT only. They may or may not work on other Kindle models. Use at your own risk. The author takes no responsibility for any damage caused by using these extensions.

## Prerequisites

- Jailbroken Kindle
- KUAL (Kindle Unified Application Launcher) installed

## Extensions

### Screensaver

Disable/enable the screensaver (prevent sleep).

Menu: `KUAL > Helper > Screensaver`

- **Show Status** - displays current screensaver state
- **Disable (Stay Awake)** - prevents Kindle from going to sleep
- **Enable (Allow Sleep)** - restores normal sleep behavior

Uses `lipc-set-prop com.lab126.powerd preventScreenSaver` to control the screensaver. State resets on reboot.

### CPU Scaling

Set the CPU frequency scaling governor.

Menu: `KUAL > Helper > CPU Scaling`

- **ondemand (default)** - scales CPU frequency based on load
- **powersave** - locks CPU to lowest frequency, saves battery
- **performance** - locks CPU to highest frequency
- **conservative** - like ondemand but with smoother transitions

Current governor is indicated with `(currently set)` in the menu. Reads/writes `/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`.

## Installation

1. Connect Kindle to your computer via USB
2. Copy the extension folders (`Screensaver`, `CPUScaling`) to the `extensions` folder on your Kindle
3. Safely eject the Kindle
4. Open KUAL on your Kindle
