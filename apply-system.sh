#!/bin/sh
pushd ~/sources/github.com/0b11stan/nixconfig
sudo nixos-rebuild switch -I nixos-config=./system/configuration.nix
popd
