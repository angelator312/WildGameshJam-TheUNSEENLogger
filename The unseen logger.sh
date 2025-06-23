#!/bin/sh
echo -ne '\033c\033]0;The unseen logger\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/The unseen logger.x86_64" "$@"
