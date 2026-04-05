#!/usr/bin/env bash

powerprofilesctl get

dbus-monitor --system "type='signal',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged',sender='org.freedesktop.UPower.PowerProfiles'" 2> /dev/null | awk '/string "ActiveProfile"/ {getline; print substr($3, 2, length($3) - 2); fflush()}'
