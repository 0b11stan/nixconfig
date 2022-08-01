#!/bin/sh

eval $(ssh-agent) && ssh-add ~/.ssh/id_rsa && ./sync-pass.sh
sudo nix-collect-garbage -d
./update-system.sh && ./apply-system.sh
./update-user.sh && ./apply-users.sh
./nix-free-space.sh
