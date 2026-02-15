{
  unstable,
  fetchFromGitHub,
}:
unstable.wineWow64Packages.wayland.overrideAttrs {
  src = fetchFromGitHub {
    owner = "LukasPAH";
    repo = "WineGDK";
    rev = "361abf3519d0062649e3493d9bf069fe7ef40017";
    hash = "sha256-7XccavZt4X3CHo9LaAAUam7HffCJl5qHTrhf6ts472s=";
  };
  patches = [];
}
