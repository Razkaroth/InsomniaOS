#!/bin/bash

# This script is used to rebuild the Insomnia system from scratch.
sudo nix-channel --update

nix flake update

IMPURITY_PATH=$(pwd) sudo --preserve-env=IMPURITY_PATH nixos-rebuild switch --upgrade --flake ./#Insomnia --impure --log-format internal-json -v &| nom --json

