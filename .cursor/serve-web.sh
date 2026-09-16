#!/usr/bin/env bash
# Serve the prebuilt Infinite Arts web build on port 4173.
set -euo pipefail

cd "$(dirname "$0")/.."

WEB_DIR="web-build"

if [ ! -d "$WEB_DIR" ]; then
  echo "web build not found; running install..." >&2
  ./.cursor/install.sh
fi

cd "$WEB_DIR"
echo "Serving Infinite Arts web build at http://0.0.0.0:4173"
exec python3 -m http.server 4173 --bind 0.0.0.0
