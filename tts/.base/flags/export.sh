#!/usr/bin/env bash
set -e
this_dir="$( cd "$( dirname "$0" )" && pwd )"

# Large
find "${this_dir}" -name '*_large.svg' -type f -print0 | \
    parallel -0 -n1 \
        inkscape --export-filename="{.}.png" {} -w 250

# Small
find "${this_dir}" -name '*_small.svg' -type f -print0 | \
    parallel -0 -n1 \
        inkscape --export-filename="{.}.png" {} -w 240
