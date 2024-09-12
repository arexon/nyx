{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx.cli-apps.tmux;

  inherit (config.colorscheme) palette;

  numux = "${pkgs.numux}/bin/numux";
  tmux = "${config.programs.tmux.package}/bin/tmux";

  fzfDefaultOpts = ''FZF_DEFAULT_OPTS=\"${config.home.sessionVariables.FZF_DEFAULT_OPTS}\"'';
in {
  options.nyx.cli-apps.tmux = {
    enable = mkBoolOpt false "Whether to enable Tmux.";
  };

  config = mkIf cfg.enable {
    systemd.user.services.tmux-server = {
      Unit = {
        Description = "Tmux server";
      };
      Service = {
        Type = "forking";
        ExecStart = "${tmux} start-server";
        ExecStop = "${tmux} kill-server";
        PassEnvironment = ["PATH"];
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };

    programs.tmux = {
      enable = true;

      prefix = "M-a";

      sensibleOnTop = true;
      terminal = "tmux-256color";

      baseIndex = 1;
      disableConfirmationPrompt = true;
      mouse = true;

      extraConfig = ''
        set-option -gas terminal-overrides '*:Tc'

        set-option -g allow-passthrough on
        set-option -ga update-environment TERM
        set-option -ga update-environment TERM_PROGRAM

        set-option -g exit-empty off

        unbind-key -a

        bind-key M-w display-popup -EB "${fzfDefaultOpts} ${numux} switch-workspace"
        bind-key M-d display-popup -EB "${fzfDefaultOpts} ${numux} delete-workspace"
        bind-key M-h run-shell -b "${numux} switch-to-home"
        bind-key M-f switch-client -l
        bind-key M-r run-shell -b "tmux source ~/.config/tmux/tmux.conf"

        bind-key d detach

        bind-key w new-window
        bind-key n next-window
        bind-key p previous-window
        bind-key N swap-window -d -t +1
        bind-key P swap-window -d -t -1
        bind-key v split-window -h
        bind-key s split-window -v
        bind-key Q kill-window

        bind-key h select-pane -L
        bind-key j select-pane -D
        bind-key k select-pane -U
        bind-key l select-pane -R
        bind-key -r H resize-pane -L
        bind-key -r J resize-pane -D
        bind-key -r K resize-pane -U
        bind-key -r L resize-pane -R
        bind-key q kill-pane

        bind-key V select-layout even-horizontal
        bind-key S select-layout even-vertical

        bind-key c copy-mode
        bind-key -T copy-mode q send -X cancel
        bind-key -T copy-mode u send -X halfpage-up
        bind-key -T copy-mode d send -X halfpage-down
        bind-key -T copy-mode h send -X cursor-left
        bind-key -T copy-mode j send -X cursor-down
        bind-key -T copy-mode k send -X cursor-up
        bind-key -T copy-mode l send -X cursor-right
        bind-key -T copy-mode v send -X begin-selection
        bind-key -T copy-mode V send -X clear-selection
        bind-key -T copy-mode y send -X copy-selection

        set-option -s escape-time 0

        set-option -g pane-border-style "fg=#${palette.base01}"
        set-option -g pane-active-border-style "fg=#${palette.base01}"

        set-option -g status-style "fg=#${palette.base06},bg=#${palette.base01}"
        set-option -g status-interval 0
        set-option -g status-left "#{window_list}"
        set-option -g status-left-length 100
        set-option -g status-right " #S "
        set-option -g window-status-separator ""
        set-option -g window-status-format "#[fg=#${palette.base03}]▏#[fg=default]#W "
        set-option -g window-status-current-format "#[fg=#${palette.base00},bg=#${palette.base0D},bold] #W "
        set-option -g message-command-style "fg=#${palette.base00},bg=#${palette.base0D}"
      '';
    };
  };
}
