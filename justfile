_default:
    just --list --unsorted

sync:
    nix run .#write-flake

os:
    nh {{ if os() == "macos" { "darwin" } else { "os" } }} switch
