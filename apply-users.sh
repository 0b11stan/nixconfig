#!/bin/sh
pushd ~/sources/github.com/0b11stan/nixconfig
home-manager switch -f ./users/tristan/home.nix
popd
