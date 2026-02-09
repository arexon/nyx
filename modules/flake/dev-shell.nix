{
  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        stylua
        lua-language-server
        just
      ];
    };
  };
}
