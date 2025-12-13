#!/bin/sh
eval $(ssh-agent) && ssh-add $(ls ~/.ssh/id_* | grep -v .pub) && pass git pull && pass git push
nix-env --delete-generations +2
sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +2
sudo nix-collect-garbage
./apply.sh
