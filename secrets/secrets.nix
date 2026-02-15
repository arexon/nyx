let
  arexon = builtins.readFile ../modules/users/arexon/public-ssh-key.pub;

  leviathan = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIESFCS7s0HzdzgQgBYb61EUZFhwBA6i46aDz5Erz+LsN";
in {
  "restic-password.age".publicKeys = [arexon leviathan];
  "restic-r2-environment.age".publicKeys = [arexon leviathan];
}
