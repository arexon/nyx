{inputs, ...}: {
  flake-file.inputs = {
    asd-ste100 = {
      url = "github:danyuchn/asd-ste100-skill";
      flake = false;
    };
  };

  flake.modules.homeManager.cli = {pkgs, ...}: {
    home.packages = [pkgs.claude-code];

    # TODO: Remove when https://github.com/NixOS/nixpkgs/pull/579756 lands.
    home.sessionVariables.CLAUDE_CODE_CERT_STORE = "bundled,system";

    home.file = {
      ".claude/skills/asd-ste100".source = inputs.asd-ste100;
      ".claude/CLAUDE.md".text = ''
        Before writing any any prose for code comments or docs, invoke the asd-ste100 skill and follow it in STE-flavored mode.
      '';
    };
  };
}
