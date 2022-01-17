#!/bin/sh
# Lyrebird installer script. If running as root then will install at /usr/local/{bin,share},
# otherwise will install at ~/.local/{bin,share}.

VERBOSE=${VERBOSE:-0}
DRYRUN=${DRYRUN:-0}

# Initial setup

if [ $DRYRUN = 1 ]; then DRYRUN_INFO=" (dryrun)"; fi
ECHO_PREFIX="[lyrebird]$DRYRUN_INFO"

info_echo() {
    echo "$ECHO_PREFIX $1"
}

warning_echo() {
    echo "[warning]$DRYRUN_INFO $1"
}

verbose_echo() {
    if [ $VERBOSE = 1 ]; then
        echo "$ECHO_PREFIX $1"
    fi
}

delete_file() {
    if [ -f "$1" ]; then
        if [ "$(stat -c '%u' $1)" -ne "$(id -u)" ]; then
            warning_echo "Cannot delete without root access: $1"
            return
        fi
        info_echo "Deleting: $1"
        if [ $DRYRUN != 1 ]; then rm "$1"; fi
    else
        verbose_echo "File not present, skipping: $1"
    fi
}

delete_dir() {
    if [ -d "$1" ]; then
        if [ "$(stat -c '%u' $1)" -ne "$(id -u)" ]; then
            warning_echo "Cannot delete without root access: $1"
            return
        fi
        info_echo "Deleting: $1"
        if [ $DRYRUN != 1 ]; then rm -rf "$1"; fi
    else
        verbose_echo "Directory not present, skipping: $1"
    fi
}

if [ "$(id -u)" -eq 0 ]; then
    INSTALL_PREFIX="${INSTALL_PREFIX:-/usr/local}"
else
    INSTALL_PREFIX="${INSTALL_PREFIX:-$HOME/.local}"
fi
verbose_echo "Uninstalling Lyrebird from prefix: ${INSTALL_PREFIX}"

delete_dir "$INSTALL_PREFIX/bin/lyrebird/"
delete_dir "$INSTALL_PREFIX/share/lyrebird/"
delete_file "$INSTALL_PREFIX/bin/lyrebird"

delete_dir "/etc/lyrebird/"

delete_dir "$HOME/.config/lyrebird/"

delete_file "$INSTALL_PREFIX/share/applications/Lyrebird.desktop"
delete_file "$INSTALL_PREFIX/share/applications/lyrebird.desktop"
