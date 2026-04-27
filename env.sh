#!/bin/bash
# Portable MangoWC path env (no hardcoded username)

export MANGO="${XDG_CONFIG_HOME:-$HOME/.config}/mango"
export MYSCRIPTS="${MANGO}/scripts"
export MYAPPS="${MYSCRIPTS}/APPS"

