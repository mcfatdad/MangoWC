#!/usr/bin/env bash
set -euo pipefail

ROOT="/mnt/SEAGATE8TB/GAMES/EMULATION/SPECCYNEXT/CSPECT"
cd "$ROOT"

# -tv disables shaders (more compatible), -w3 scales the window,
# -zxnext selects Next mode, -s28 sets 28MHz, and **note the equals sign** in -mmc=
exec env MONO_IOMAP=all mono ./CSpect.exe -tv -w3 -zxnext -vsync -threaded -s28 -mmc="$ROOT/TBBlue.img"

