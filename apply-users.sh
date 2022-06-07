#!/bin/sh
pushd ~/.dotfiles
home-manager switch -f ./users/tristan/home.nix
popd
