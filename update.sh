#!/bin/bash
set -eu

version=$1
workdir="$(pwd)"
if test -d "$version"; then
    echo "version $version already exists!"
    exit 1
fi
tempdir="$(mktemp -d)"
trap 'rm -rf $tempdir' EXIT

cd "$tempdir"
baseurl="https://github.com/mpi4py/mpi4py/releases/download"
curl -sL "$baseurl/$version/mpi4py-$version.tar.gz" | tar xz

cd "$workdir"
mv "$tempdir/mpi4py-$version/docs" "$version"
ln -sf "$version" "stable"

git add "$version" "stable"
git commit -m "$version"
