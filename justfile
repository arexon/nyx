_default:
    just --list --unsorted

sync:
    nix run .#write-flake

os:
    nh os switch

hm:
    nh home switch
