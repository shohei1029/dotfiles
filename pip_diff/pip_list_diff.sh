#!/bin/zsh
set -euo pipefail

pip list > pip_new.txt
cut -f 1 -d " " < pip_new.txt | sort > pip_new2.txt
DIR=$PWD

cd "$HOME"
pip list > "$DIR"/pip_old.txt
cut -f 1 -d " " < "$DIR"/pip_old.txt | sort > "$DIR"/pip_old2.txt

cd "$DIR"
diff pip_old2.txt pip_new2.txt

