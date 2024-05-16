#!/bin/bash
set -euo pipefail

error() { echo "error: $1"; exit 1; }

test -n "${1-}" || error "expecting GHA workflow run ID"
gh run download --repo mpi4py/mpi4py -n mpi4py-docs "$1"
docdir="mpi4py-docs"
rm -rf "$docdir"
unzip -q "$docdir.zip"

version=$(cat "$docdir/version")
test ! -d "$version" || error "$version already exists!"
rm "$docdir/version"
mv "$docdir" "$version"

rm -f "stable"
ln -sf "$version" "stable"
git add "$version" "stable"
git commit -m "$version"
