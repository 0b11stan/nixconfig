#!/bin/sh
pushd ~/.dotfiles
nix build .#homeManagerConfigurations.tristan.activationPackage
./result/activate
popd
