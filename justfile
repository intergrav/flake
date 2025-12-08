# update flake
up:
    nix flake update --flake . --commit-lock-file

# switch to flake
sw:
    #!/usr/bin/env bash
    if [[ "$(uname -s)" == "Darwin" ]]; then
        echo "detected darwin, running morlana..."
        nix run github:ryanccn/morlana -- switch --flake .
    elif [[ "$(uname -s)" == "Linux" ]]; then
        echo "detected linux, running sudo nixos-rebuild..."
        sudo nixos-rebuild switch --flake .
    else
        echo "unsupported os"
        exit 1
    fi

# garbage collection/cleanup
gc:
    sudo nix-collect-garbage -d && sudo nix-store --optimise
    nix-collect-garbage -d && nix-store --optimise