#!/usr/bin/env bash
# Idempotent bootstrap for the Infinite Arts releases repository.
#
# The main branch is a distribution repo: it holds the README and the
# release-validation workflows. The actual playable application is a prebuilt
# static web build that lives on the `web-preview` branch. This script
# materializes that build into ./web-build so it can be served locally for
# development and end-to-end verification.
set -euo pipefail

cd "$(dirname "$0")/.."

WEB_DIR="web-build"

if git fetch --depth 1 origin web-preview 2>/dev/null; then
  rm -rf "$WEB_DIR"
  mkdir -p "$WEB_DIR"
  git archive FETCH_HEAD | tar -x -C "$WEB_DIR"
  echo "Web build ready in ./$WEB_DIR ($(du -sh "$WEB_DIR" | cut -f1))"
else
  echo "warning: web-preview branch not reachable; skipping web build materialization" >&2
fi
