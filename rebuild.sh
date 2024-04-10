#!/bin/bash

# This script is used to rebuild the Insomnia system from scratch.
IMPURITY_PATH=$(pwd) sudo --preserve-env=IMPURITY_PATH nixos-rebuild switch --flake ./#Insomnia --impure

