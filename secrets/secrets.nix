let
  primary = "age14jgf5lrmmgg45tqsrg3y6um3x2cm0k6enssm8da5vnx2fyelu58qegcv8y";

  falcon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMKnYRP4yyR232d5KbVBkZpe3ikBM3nXJnFa7yKCc9ON root@falcon";
in {
  "arexon-private-ssh-key.age".publicKeys = [primary falcon];

  "arexon-password.age".publicKeys = [primary falcon];

  "root-password.age".publicKeys = [primary falcon];
}
