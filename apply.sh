#!/bin/sh
sudo nixos-rebuild switch -I nixos-config=./system/configuration.nix --upgrade-all
