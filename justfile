# update flake
up:
    nix flake update --flake . --commit-lock-file

# switch to flake
sw:
    #!/usr/bin/env bash
    if [[ "$(uname -s)" == "Darwin" ]]; then
        echo "detected darwin, using nh darwin..."
        nix run nixpkgs#nh darwin switch .
    elif [[ "$(uname -s)" == "Linux" ]]; then
        echo "detected linux, using nh os..."
        nix run nixpkgs#nh os switch .
    else
        echo "unsupported os"
        exit 1
    fi

# garbage collection/cleanup
gc:
    nix run nixpkgs#nh clean all