#!/bin/sh
eval $(ssh-agent) && ssh-add ~/.ssh/id_rsa && ./sync-pass.sh
./update-system.sh && ./apply-system.sh
./update-user.sh && ./apply-users.sh
sudo nix-collect-garbage --delete-older-than 30d
