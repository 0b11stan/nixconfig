#!/bin/sh

./update-system.sh && ./apply-system.sh
./update-user.sh && ./apply-user.sh
./nix-free-space.sh

eval $(ssh-agent) && ssh-add ~/.ssh/id_rsa && ./sync-pass.sh
