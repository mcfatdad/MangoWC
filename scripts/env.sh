#!/usr/bin/env bash
# Portable MangoWC environment

export MANGO="${XDG_CONFIG_HOME:-$HOME/.config}/mango"
export MYSCRIPTS="${MANGO}/scripts"
export MYAPPS="${MYSCRIPTS}/APPS"

case ":$PATH:" in
  *":$MYSCRIPTS:"*) ;;
  *) export PATH="$MYSCRIPTS:$PATH" ;;
esac

case ":$PATH:" in
  *":$MYAPPS:"*) ;;
  *) export PATH="$MYAPPS:$PATH" ;;
esac

case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) export PATH="$HOME/.local/bin:$PATH" ;;
esac
