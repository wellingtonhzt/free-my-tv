#!/usr/bin/env bash
# Reproducible personal profile; local settings and signing key are never committed.
set -euo pipefail
cd "$(dirname "$0")"
if [ ! -f config.properties ]; then
  cp config.personal.example.properties config.properties
  echo "Created config.properties. Set your city/coordinates locally before installing."
fi
if ! grep -Eq '^[[:space:]]*screensaver[[:space:]]*=[[:space:]]*false[[:space:]]*$' config.properties; then
  echo "Set screensaver=false in config.properties to preserve the original screensaver." >&2
  exit 1
fi
exec bash ./build.sh
