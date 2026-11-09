#!/bin/sh
ssh-add ~/.ssh/er
sudo nixos-rebuild switch -I nixos-config=./system/configuration.nix


