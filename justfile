_default:
    just --list --unsorted

sync:
    nix run .#write-flake

switch:
    nh {{ if os() == "macos" { "darwin" } else { "os" } }} switch
