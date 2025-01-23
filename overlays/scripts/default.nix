_: prev: let
  writeNushellScript = {
    name,
    pkgs,
    deps ? [],
  }: let
    formattedDeps =
      builtins.concatStringsSep " "
      (builtins.map (dep: ''"${dep}/bin"'') deps);
  in
    pkgs.writeTextFile {
      inherit name;
      destination = "/bin/${name}";
      executable = true;
      text =
        "#!${pkgs.nushell}/bin/nu\n"
        + (
          if (builtins.length deps > 0)
          then ''
            use std "path add"
            path add ${formattedDeps}
          ''
          else ""
        )
        + (builtins.readFile ./${name}.nu);
    };
in {
  numux = writeNushellScript {
    name = "numux";
    pkgs = prev;
  };
  ss-to-r2 = writeNushellScript {
    name = "ss-to-r2";
    pkgs = prev;
    deps = with prev; [s3cmd xclip];
  };
}
