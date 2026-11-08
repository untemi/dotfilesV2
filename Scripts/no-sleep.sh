#!/usr/bin/env bash
# nosleep.sh - inhibit system sleep/idle while running
#
# Usage:
#   ./nosleep.sh                  # inhibit indefinitely, Ctrl+C to stop
#   ./nosleep.sh 2h               # inhibit for 2 hours then exit
#   ./nosleep.sh -- long-command  # inhibit only while long-command runs

set -euo pipefail

WHO="nosleep.sh"
WHY="Manual sleep inhibit requested by user"
WHAT="sleep:idle:handle-lid-switch"

if [[ "${1:-}" == "--" ]]; then
  shift
  echo "Inhibiting sleep while running: $*"
  exec systemd-inhibit --what="$WHAT" --who="$WHO" --why="$WHY" -- "$@"
elif [[ -n "${1:-}" ]]; then
  DURATION="$1"
  echo "Inhibiting sleep for $DURATION (Ctrl+C to stop early)..."
  exec systemd-inhibit --what="$WHAT" --who="$WHO" --why="$WHY" -- sleep "$DURATION"
else
  echo "Inhibiting sleep indefinitely (Ctrl+C to stop)..."
  exec systemd-inhibit --what="$WHAT" --who="$WHO" --why="$WHY" -- sleep infinity
fi
