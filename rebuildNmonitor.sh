#!/bin/fish

# This script is used to rebuild the Insomnia system from scratch.
sudo echo "Root access granted."

IMPURITY_PATH=$(pwd) sudo --preserve-env=IMPURITY_PATH nixos-rebuild switch --flake ./#Insomnia --impure --log-format internal-json -v &| nom --json


