# Insomnia OS
- Based on ends-4's NixOS config
- It's impure but it works, I actually prefer it this way as you can configure those things that are easier the gui way. 

# Installation
## Installing the whole system
- Please be advised that this flake includes my hardware configuration
  - You will need to refractor your own hardware config into this flake.
```bash
git clone https://github.com/Razkaroth/InsomniaOS.git && cd InsomniaOS
IMPURITY_PATH=$(pwd) sudo --preserve-env=IMPURITY_PATH nixos-rebuild switch --flake . --impure
```

