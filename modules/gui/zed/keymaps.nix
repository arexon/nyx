{
  flake.modules.homeManager.gui = {
    programs.zed-editor.mutableUserKeymaps = false;
    xdg.configFile."zed/keymap.json".force = true;

    programs.zed-editor.userKeymaps = [
      {
        context = "Workspace || Editor || Terminal || AcpThread";
        bindings = {
          "cmd-e" = "project_panel::ToggleFocus";
          "cmd-g" = "git_panel::ToggleFocus";
          "cmd-l" = "agent::ToggleFocus";
          "cmd-alt-l" = "multi_workspace::ToggleWorkspaceSidebar";
          "cmd-alt-y" = "workspace::ToggleAllDocks";
          "cmd-alt-p" = "git::ForcePush";
        };
      }

      {
        context = "Workspace || Editor || Terminal";
        bindings = {
          "alt-h" = "workspace::ActivatePaneLeft";
          "alt-l" = "workspace::ActivatePaneRight";
          "alt-k" = "workspace::ActivatePaneUp";
          "alt-j" = "workspace::ActivatePaneDown";
          "alt-shift-h" = "vim::ResizePaneLeft";
          "alt-shift-l" = "vim::ResizePaneRight";
          "alt-shift-k" = "vim::ResizePaneUp";
          "alt-shift-j" = "vim::ResizePaneDown";
          "alt-=" = "vim::ResetPaneSizes";
          "alt-v" = "pane::SplitRight";
          "alt-s" = "pane::SplitDown";

          "cmd-alt-w" = "pane::CloseAllItems";
          "alt-m" = "pane::TogglePinTab";

          "cmd-shift-l" = ["agent::NewExternalAgentThread" {agent = "claude-acp";}];
        };
      }

      {
        context = "Editor && vim_mode == helix_normal && !menu";
        bindings = {
          "escape" = ["action::Sequence" ["vim::HelixCollapseSelection" "vim::HelixKeepNewestSelection"]];
          "ctrl-u" = ["action::Sequence" [["editor::MoveUpByLines" {lines = 10;}] "editor::ScrollCursorCenter"]];
          "ctrl-d" = ["action::Sequence" [["editor::MoveDownByLines" {lines = 10;}] "editor::ScrollCursorCenter"]];
          "ctrl-s" = "workspace::Save";
          "alt-x" = "git::Restore";
          "space d" = "diagnostics::DeployCurrentFile";
          "space shift-d" = "diagnostics::Deploy";
          "space w g d" = "editor::GoToDefinitionSplit";
          "space w g shift-d" = "editor::GoToDeclarationSplit";
          "space w g y" = "editor::GoToTypeDefinitionSplit";
          "space w g i" = "editor::GoToImplementationSplit";
        };
      }
      {
        context = "Editor && vim_mode == helix_select && !menu";
        bindings = {
          ";" = ["action::Sequence" ["vim::HelixCollapseSelection" "vim::SwitchToHelixNormalMode"]];
        };
      }

      {
        context = "ProjectPanel && not_editing";
        bindings = {
          "o" = "project_panel::OpenPermanent";
          "shift-o" = "workspace::OpenWithSystem";
          "a" = "project_panel::NewFile";
          "shift-a" = "project_panel::NewDirectory";
          "r" = "project_panel::Rename";
          "d" = "project_panel::Trash";
          "y" = "project_panel::Copy";
          "x" = "project_panel::Cut";
          "p" = "project_panel::Paste";
          "." = "project_panel::ToggleHideHidden";
          "s" = "file_finder::Toggle";
          "shift-s" = "project_panel::NewSearchInDirectory";
          "c c" = "workspace::CopyPath";
          "c r" = "workspace::CopyRelativePath";
          "q" = "workspace::CloseActiveDock";
          "g e" = "menu::SelectLast";
        };
      }

      {
        context = "GitPanel && (ChangesList || HistoryList) && !GitBranchSelector && !GitRepositorySelector";
        bindings = {
          "[" = "git_panel::ActivateChangesTab";
          "]" = "git_panel::ActivateHistoryTab";
          "b" = "git::Switch";
          "shift-s" = "git::ViewStash";
          "p" = "git::Pull";
          "shift-p" = "git::Push";
          "f" = "git::Fetch";
          "q" = "workspace::CloseActiveDock";
        };
      }
      {
        context = "GitPanel && ChangesList && !GitBranchSelector && !GitRepositorySelector";
        bindings = {
          "a" = "git::StageAll";
          "c" = "git_panel::FocusEditor";
          "shift-c" = "git::ExpandCommitEditor";
          "shift-a" = "git::Amend";
          "d" = ["git::RestoreFile" {skip_prompt = false;}];
          "shift-d" = "git::RestoreTrackedFiles";
          "s" = "git::StashAll";
          "`" = "git_panel::ToggleTreeView";
        };
      }
      {
        context = "CommitEditor > Editor";
        bindings = {
          "enter" = "git::Commit";
          "shift-enter" = "editor::Newline";
        };
      }

      {
        context = "AcpThread > Editor";
        bindings = {
          "ctrl-c" = "editor::Cancel";
        };
      }
      {
        context = "AcpThread > Editor && vim_mode == helix_normal";
        bindings = {
          "escape" = "editor::Cancel";
        };
      }
      {
        context = "Workspace";
        bindings = {
          "cmd-alt-j" = null;
          "cmd-shift-e" = null;
          "ctrl-shift-g" = null;
          "cmd-?" = null;
          "cmd-k cmd-left" = null;
          "cmd-k cmd-right" = null;
          "cmd-k cmd-up" = null;
          "cmd-k cmd-down" = null;
          "ctrl-~" = null;
        };
      }
      {
        context = "AgentPanel";
        bindings = {
          "cmd-shift-e" = null;
        };
      }
      {
        context = "VimControl && !menu || !Editor && !Terminal";
        bindings = {
          "ctrl-w left" = null;
          "ctrl-w right" = null;
          "ctrl-w up" = null;
          "ctrl-w down" = null;
          "ctrl-w ctrl-h" = null;
          "ctrl-w ctrl-l" = null;
          "ctrl-w ctrl-k" = null;
          "ctrl-w ctrl-j" = null;
          "ctrl-w h" = null;
          "ctrl-w l" = null;
          "ctrl-w k" = null;
          "ctrl-w j" = null;
          "ctrl-w >" = null;
          "ctrl-w <" = null;
          "ctrl-w -" = null;
          "ctrl-w +" = null;
          "ctrl-w =" = null;
          "ctrl-w g t" = null;
          "ctrl-w ctrl-g t" = null;
          "ctrl-w g shift-t" = null;
          "ctrl-w ctrl-g shift-t" = null;
          "ctrl-w ctrl-v" = null;
          "ctrl-w v" = null;
          "ctrl-w shift-s" = null;
          "ctrl-w ctrl-s" = null;
          "ctrl-w s" = null;
          "ctrl-w ctrl-a" = null;
          "ctrl-w a" = null;
        };
      }
      {
        context = "VimControl && !menu";
        bindings = {
          "ctrl-w d" = null;
          "ctrl-w g d" = null;
          "ctrl-w ]" = null;
          "ctrl-w ctrl-]" = null;
          "ctrl-w shift-d" = null;
          "ctrl-w g shift-d" = null;
          "ctrl-w space" = null;
          "ctrl-w g space" = null;
        };
      }
      {
        context = "(vim_mode == helix_normal || vim_mode == helix_select) && !menu";
        bindings = {
          "space w v" = null;
          "space w s" = null;
          "space w h" = null;
          "space w j" = null;
          "space w k" = null;
          "space w l" = null;
          "space w r" = null;
          "space w d" = null;
          "g n" = null;
          "shift-l" = null;
          "g p" = null;
          "shift-h" = null;
        };
      }
      {
        context = "!Editor && !Terminal";
        bindings = {
          "space w h" = null;
          "space w j" = null;
          "space w k" = null;
          "space w l" = null;
        };
      }
      {
        context = "Pane";
        bindings = {
          "alt-cmd-left" = null;
          "cmd-{" = null;
          "alt-cmd-right" = null;
          "cmd-}" = null;
          "ctrl-shift-pageup" = null;
          "ctrl-shift-pagedown" = null;
          "cmd-k down" = null;
          "cmd-k right" = null;
          "cmd-k shift-enter" = null;
        };
      }
      {
        context = "Editor";
        bindings = {
          "cmd-\\" = null;
        };
      }
      {
        context = "Terminal";
        bindings = {
          "ctrl-alt-down" = null;
          "ctrl-alt-right" = null;
          "cmd-d" = null;
        };
      }
      {
        context = "vim_mode == helix_select";
        bindings = {
          "ctrl-pageup" = null;
          "ctrl-pagedown" = null;
        };
      }
      {
        context = "(vim_mode == normal || vim_mode == helix_normal) && !menu";
        bindings = {
          "ctrl-pagedown" = null;
          "ctrl-pageup" = null;
        };
      }
      {
        context = "ProjectPanel && not_editing";
        bindings = {
          "%" = null;
          "/" = null;
          "shift-r" = null;
          "t" = null;
        };
      }
      {
        context = "GitPanel && ChangesList && !GitBranchSelector && !GitRepositorySelector";
        bindings = {
          "i" = null;
          "shift-x" = null;
        };
      }
      {
        context = "GitPanel";
        bindings = {
          "ctrl-g ctrl-g" = null;
          "ctrl-g up" = null;
          "ctrl-g shift-up" = null;
          "ctrl-g down" = null;
          "ctrl-g backspace" = null;
        };
      }
    ];
  };
}
