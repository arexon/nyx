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
        ''
          #!${pkgs.nushell}/bin/nu

          ${builtins.readFile ./${name}.nu}
        ''
        + (
          if (builtins.length deps != 0)
          then ''
            use std "path add"
            path add ${formattedDeps}
          ''
          else ""
        );
    };
in {
  numux = writeNushellScript {
    name = "numux";
    pkgs = prev;
  };
}
