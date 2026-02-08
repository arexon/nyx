{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "color-lsp";
  version = "0.2.2";

  src = fetchFromGitHub {
    owner = "huacnlee";
    repo = "color-lsp";
    tag = "v${version}";
    hash = "sha256-U0pTzW2PCgMxVsa1QX9MC249PXXL2KvRSN1Em2WvIeI=";
  };

  cargoHash = "sha256-etK+9fcKS+y+0C36vJrMkQ0yyVSpCW/DLKg4nTw3LrE=";

  meta.mainProgram = pname;
}
