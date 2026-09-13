{
  flake.modules.homeManager.cli = {
    config,
    pkgs,
    ...
  }: let
    catppuccinSrc = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/anomalyco/opencode/fe0c4f8c74385ab4c4bb14dfe594a5f5ac91e65a/packages/tui/src/theme/assets/catppuccin.json";
      hash = "sha256-KMCkyWYEtIDn4EFpn4/dfopYbIKo/ZA9Z07QitRLOds=";
    };
    catppuccin = builtins.readFile catppuccinSrc |> builtins.fromJSON;
    catppuccinTransparent =
      catppuccin
      // {
        theme =
          catppuccin.theme
          // {
            background = "none";
            backgroundPanel = "none";
            backgroundElement = "none";
            diffAddedBg = "none";
            diffRemovedBg = "none";
            diffContextBg = "none";
            diffAddedLineNumberBg = "none";
            diffRemovedLineNumberBg = "none";
          };
      };
  in {
    programs.opencode = {
      enable = true;
      themes.catppuccin = catppuccinTransparent;
      tui.theme = "catppuccin";
      settings = {
        plugin = [
          "@dietrichgebert/ponytail@4.9.0"
          "@cortexkit/opencode-openai-auth@0.7.1"
          "@cortexkit/opencode-anthropic-auth@1.22.0"
          "opencode-ast-grep@0.1.1"
          "opencode-fff-search@0.8.0"
        ];
        mcp.ida-pro-mcp = {
          type = "local";
          command = ["${config.xdg.dataHome}/uv/tools/ida-pro-mcp/bin/idalib-mcp" "--stdio"];
          enabled = true;
          timeout = 120000;
        };
      };
    };
  };
}
