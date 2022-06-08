#!/bin/sh
pushd ~/sources/0b11stan/nixconfig
home-manager switch -f ./users/tristan/home.nix
popd
