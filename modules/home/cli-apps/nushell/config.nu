let fish_completer = {|spans: list<string>|
    fish --init-command $'complete --do-complete "($spans | str join " ")"'
    | $"value(char tab)description(char newline)" + $in
    | from tsv --flexible --no-infer
}
let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
}
let external_completer = {|spans: list<string>|
    let expanded_alias = scope aliases
        | where name == $spans.0
        | get --ignore-errors expansion.0

    let spans = if $expanded_alias != null {
        $spans | skip 1 | prepend ($expanded_alias | split row " ")
    } else {
        $spans
    }

    match $spans.0 {
        nu => $fish_completer
        git => $fish_completer
        _ => $carapace_completer
    } | do $in $spans
}

# `ls` doesn't group directories first <https://github.com/nushell/nushell/issues/7881>
def l []: nothing -> table {
    ls --all | sort-by type
}
def ll []: nothing -> table {
    ls --long | sort-by type
}
def lla []: nothing -> table {
    ls --long --all | sort-by type
}

alias nd = ^nix develop --command nu

alias nos = ^nh os switch
alias nob = ^nh os boot

alias lg = ^lazygit
alias sg = ^ast-grep
alias cat = ^bat

$env.PROMPT_INDICATOR_VI_INSERT = ''
$env.PROMPT_INDICATOR_VI_NORMAL = '' 

$env.config = {
    cursor_shape: {
        vi_insert: line
        vi_normal: block
    }
    table: {
        mode: compact
        index_mode: never
    }
    history: {
        file_format: "sqlite"
    }
    show_banner: false
    edit_mode: vi
    filesize: {
        unit: "metric"
    }
    completions: {
        algorithm: "prefix"
        external: {
            enable: true
            completer: $external_completer
        }
    }
    display_errors: {
        exit_code: false
    }
    keybindings: [
        {
            name: clear_screen
            modifier: control
            keycode: char_l
            mode: [vi_normal, vi_insert]
            event: {
                send: executehostcommand
                cmd: "printf '\e[H\ec\e[100B'"
            }
        }
    ]
}
