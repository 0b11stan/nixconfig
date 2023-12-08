#!/bin/sh
eval $(ssh-agent) && ssh-add ~/.ssh/id_rsa && pass git pull && pass git push
./apply.sh && sudo nix-collect-garbage --delete-older-than 15d
