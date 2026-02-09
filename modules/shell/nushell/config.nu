let fish_completer = {|spans: list<string>|
    ^fish --command $"complete '--do-complete=($spans | str replace --all "'" "\\'" | str join ' ')'"
    | from tsv --flexible --noheaders --no-infer
    | rename value description
    | update value {|row|
        let value = $row.value
        let need_quote = ['\' ',' '[' ']' '(' ')' ' ' '\t' "'" '"' "`"] | any {$in in $value}
        if ($need_quote and ($value | path exists)) {
            let expanded_path = if ($value starts-with ~) {$value | path expand --no-symlink} else {$value}
            $'"($expanded_path | str replace --all "\"" "\\\"")"'
        } else {$value}
    }
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

alias lg = ^lazygit
alias sg = ^ast-grep
alias cat = ^bat
alias tw = ^timew

$env.PROMPT_INDICATOR_VI_INSERT = ''
$env.PROMPT_INDICATOR_VI_NORMAL = '' 
$env.EDITOR = 'hx' 

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
            completer: $fish_completer
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

$env.config = ($env.config | upsert hooks.env_change.PWD {|config|
    [
        {
            condition: {|_, after|
                $after | path join dev.nu | path exists
            }
            code: "overlay use dev.nu"
        }
        {
            condition: {|before, _|
                (not ($before | is-empty)
                    and ($before | path join dev.nu | path exists)
                    and (overlay list | where name == "dev" | get active | first))
            }
            code: "overlay hide dev --keep-env [ PWD ]"
        }
    ]
})
