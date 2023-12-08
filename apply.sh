#!/bin/sh
sudo HOSTNAME=$HOSTNAME \
  nixos-rebuild switch -I nixos-config=./system/configuration.nix --upgrade-all
