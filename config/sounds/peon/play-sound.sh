#!/bin/bash
# Warcraft Peon sound dispatcher for Claude Code hooks
# Usage: play-sound.sh <category>
# Categories: acknowledge, complete, start, idle
#
# Plays a random sound from the given category using afplay (macOS).
# Runs in background so hooks don't block Claude.
# Silently no-ops if sounds directory or afplay is missing.

set -euo pipefail

SOUNDS_DIR="$(cd "$(dirname "$0")" && pwd)"
CATEGORY="${1:-}"

# No-op if afplay not available (non-macOS)
command -v afplay >/dev/null 2>&1 || exit 0

# Pick a random file from an array
pick_random() {
    local files=("$@")
    local count=${#files[@]}
    [[ $count -eq 0 ]] && exit 0
    local index=$((RANDOM % count))
    echo "${files[$index]}"
}

case "$CATEGORY" in
    acknowledge)
        files=(
            "$SOUNDS_DIR/work-work.mp3"
            "$SOUNDS_DIR/yes-me-lord.mp3"
            "$SOUNDS_DIR/i-can-do-that.mp3"
        )
        ;;
    complete)
        files=(
            "$SOUNDS_DIR/jobs-done.mp3"
            "$SOUNDS_DIR/jobs-done-peasant.mp3"
            "$SOUNDS_DIR/work-complete.mp3"
        )
        ;;
    start)
        files=(
            "$SOUNDS_DIR/ready-to-work.mp3"
            "$SOUNDS_DIR/work-work.mp3"
        )
        ;;
    idle)
        files=(
            "$SOUNDS_DIR/ready-to-work.mp3"
        )
        ;;
    *)
        exit 0
        ;;
esac

sound=$(pick_random "${files[@]}")
[[ -f "$sound" ]] && afplay "$sound" &
exit 0
