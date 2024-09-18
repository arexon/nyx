{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.apps.vscode;
in {
  options.nyx.apps.vscode = {
    enable = mkBoolOpt false "Whether to enable VS Code.";
  };

  config = mkIf cfg.enable {
    # Because Snowstorm..
    programs.vscode.enable = true;
  };
}
