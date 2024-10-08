#!/usr/bin/env bash

cd "$(dirname "$0")"

# system config directory
configDir="$HOME/.config"
# new config directory
dotconfigDir="$(pwd)/dotconfig"

if [[ "$1" == "" ]] ; then
    echo "usage: ./backup.sh <dir>"
    echo "remove \"$dotconfigDir/<dir>\" if exist"
    echo "and then \"$configDir/<dir>\" will be copied to \"$dotconfigDir\""
    exit
fi

if [[ -d "$dotconfigDir/$1" ]] ; then
    echo "remove \"$dotconfigDir/$1\""
    rm -r "$dotconfigDir/$1"
fi

echo "copying \"$configDir/$1\" to \"$dotconfigDir\"..."
cp -r "$configDir/$1" "$dotconfigDir"
