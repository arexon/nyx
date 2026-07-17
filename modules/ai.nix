{
  flake.modules.homeManager.ai = {
    config,
    pkgs,
    lib,
    ...
  }: {
    launchd.agents.llama-server = {
      enable = true;
      config = {
        ProgramArguments = [
          (lib.getExe' pkgs.llama-cpp "llama-server")
          "-m"
          "${config.home.homeDirectory}/Models/Qwen3-Coder-Next-UD-Q3_K_S.gguf"
          "--host"
          "127.0.0.1"
          "--port"
          "1337"
          "-c"
          "65536"
          "-ngl"
          "99"
          "-np"
          "1"
          "--cache-reuse"
          "256"
        ];
        RunAtLoad = true;
        KeepAlive = true;
        ProcessType = "Interactive";
        StandardOutPath = "/tmp/llama-server.log";
        StandardErrorPath = "/tmp/llama-server.err";
      };
    };
  };
}
