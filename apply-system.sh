#!/bin/sh
pushd ~/sources/0b11stan/nixconfig
sudo nixos-rebuild switch -I nixos-config=./system/configuration.nix
popd
