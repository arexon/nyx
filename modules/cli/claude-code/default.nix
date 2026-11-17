{inputs, ...}: {
  flake-file.inputs = {
    agent-style = {
      url = "github:yzhao062/agent-style";
      flake = false;
    };
  };

  flake.modules.homeManager.cli = {pkgs, ...}: {
    home.packages = [pkgs.claude-code];

    home.file = {
      ".claude/skills/agent-style".source = "${inputs.agent-style}/agents/anthropic-skill";
      ".claude/skills/api-docs".source = ./skills/api-docs;
      ".claude/CLAUDE.md".text = ''
        - Before writing any prose for code comments or docs, invoke the agent-style skill.
        - Before writing doc comments for public APIs, invoke the api-docs skill.
        - Never run `git commit` or `git commit --amend`. Leave all changes uncommitted for the user to commit.
      '';
    };
  };
}
