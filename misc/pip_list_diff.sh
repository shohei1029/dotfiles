#!/bin/bash
set -euo pipefail

diff --side-by-side <(cd $HOME; pip list --format=columns | cut -f 1 -d" ") <(pip list --format=columns | cut -f 1 -d" ")
