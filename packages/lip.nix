{
  lib,
  fetchzip,
  writeShellApplication,
  wine64,
}: let
  version = "0.35.0";

  lip = fetchzip {
    url = "https://github.com/LiteLDev/lip/releases/download/v${version}/lip-${version}-win-x64.zip";
    hash = "sha256-0QZwtRuE4VP1As/pKFlvXOV/xEmsJVI8EYfjzc54+X8=";
    stripRoot = false;
  };

  dotnet-runtime = fetchzip {
    url = "https://builds.dotnet.microsoft.com/dotnet/Runtime/10.0.14/dotnet-runtime-10.0.14-win-x64.zip";
    hash = "sha256-Zid4ksYbIcV9zfRVCOlnxn8xdKbGSyUHonQ4KtGnMbs=";
    stripRoot = false;
  };

  # Wine maps the Unix root to drive Z:.
  toWinePath = path: "Z:" + lib.replaceStrings ["/"] ["\\"] (toString path);
in
  writeShellApplication {
    name = "lip";

    runtimeInputs = [wine64];

    text = ''
      export WINEPREFIX="''${XDG_DATA_HOME:-$HOME/.local/share}/lip/prefix"
      export WINEDEBUG="''${WINEDEBUG:--all}"
      export WINEDLLOVERRIDES="mscoree,mshtml=d;winemenubuilder.exe=d"
      export DOTNET_ROOT='${toWinePath dotnet-runtime}'

      exec wine ${lip}/lip.exe "$@"
    '';

    meta = {
      description = "Package installer for LeviMC, run under Wine";
      homepage = "https://github.com/LiteLDev/lip";
      license = lib.licenses.gpl3Only;
      platforms = ["x86_64-linux"];
      mainProgram = "lip";
    };
  }
