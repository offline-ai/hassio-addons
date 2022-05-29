#!/usr/bin/env bash

PYTHON=/home/tts/app/.venv/bin/python3

function jq {
    "${PYTHON}" -c 'import sys; import json; print(json.load(open(sys.argv[2]))[sys.argv[1]])' "$@"
}

export -f jq

TTS_ARGS=()

if [[ -f "${CONFIG_PATH}" ]]; then
    # Hass.IO configuration

    # Directory to cache WAV files (use /tmp if no argument)
    cache_dir="$(jq 'cache_dir' "${CONFIG_PATH}")"
    if [[ -n "${cache_dir}" ]]; then
        TTS_ARGS+=('--cache' "${cache_dir}")
    fi

    # If true, print DEBUG messages to log
    debug="$(jq 'debug' "${CONFIG_PATH}")"
    if [[ "${debug}" == 'True' ]]; then
        TTS_ARGS+=('--debug')
    fi

    echo "TTS_ARGS: ${TTS_ARGS[@]}"
fi

cd /home/tts/app

if [[ -z "${TTS_ARGS[*]}" ]]; then
    "${PYTHON}" server.py "$@"
else
    "${PYTHON}" server.py "${TTS_ARGS[@]}" "$@"
fi
