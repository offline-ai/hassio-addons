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

    log_level="$(jq 'log_level' "${CONFIG_PATH}")"
    if [[ -n "${log_level}" ]]; then
        TTS_ARGS+=('--log' "${log_level}")
    fi

    preferred_voices="$(jq 'preferred_voices' "${CONFIG_PATH}" | sed "s/'/\"/g")"
    if [ preferred_voices != "[]" ]; then
        echo "$preferred_voices" > /home/tts/app/PREFERRED_VOICES
    fi

    if [[  $log_level == "debug" ]]; then
        echo "${TTS_ARGS[@]}"
    fi
fi

cd /home/tts/app

if [[ -z "${TTS_ARGS[*]}" ]]; then
    "${PYTHON}" server.py "$@"
else
    "${PYTHON}" server.py "${TTS_ARGS[@]}" "$@"
fi
