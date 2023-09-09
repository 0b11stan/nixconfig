#!/bin/sh
eval $(ssh-agent) && ssh-add ~/.ssh/id_rsa && pass git pull && pass git push
sudo nix-channel --update
sudo HOSTNAME=$HOSTNAME \
  nixos-rebuild switch -I nixos-config=./system/configuration.nix
sudo nix-collect-garbage --delete-older-than 30d
