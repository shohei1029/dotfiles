#!/bin/bash
set -euo pipefail

pip list | cut -f 1 -d " " | sort > pip_new2.txt
DIR=$PWD

cd "$HOME"
pip list | cut -f 1 -d " " | sort > "$DIR"/pip_old2.txt

cd "$DIR"
diff pip_old2.txt pip_new2.txt | sort | grep -e '>' -e '<'

