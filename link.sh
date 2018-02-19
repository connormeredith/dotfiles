#!/bin/bash

for src in $(find "$(pwd -P)" -maxdepth 2 -name '*.symlink' -not -path '*.git*')
do
  dst="$HOME/.$(basename "${src%.*}")"
  echo "$src -> $dst"
  ln -s "$src" "$dst"
done
