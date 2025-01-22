def main []: nothing -> nothing {}

def 'main list' []: nothing -> string {
    get-history | to text
}

def 'main switch' [n: number, --update]: nothing -> nothing {
    if $update { update-history }

    get-history
    | each { if not ($in | get-file-path | path exists) { '0' } else { $in } }
    | save -f (get-history-path)

    let file = get-history | get ($n - 1)
    if $file == '0' { return }

    ^tmux send-keys $':harpoon-open ($file)' C-m
}

def 'main set' [n: number]: nothing -> nothing {
    get-history
    | enumerate
    | each { if $in.index == $n - 1 { get-status } else { $in.item } }
    | save -f (get-history-path)
}

def 'main update' []: nothing -> nothing {
    update-history
}

def update-history []: nothing -> nothing {
    let status = get-status
    let file_path = $status | get-file-path
    get-history
    | each { if ($in | get-file-path) == $file_path { $status } else { $in } }
    | save -f (get-history-path)
}

def get-status []: nothing -> string {
    ^tmux capture-pane -p
    | ^rg -o '( NOR| INS)\s+([^\s]+).*?(\d+):(\d+)' --only-matching --replace '$2:$3:$4'
}

def get-file-path []: string -> path {
    split row ':' | get 0
}

def get-history []: nothing -> list<string> {
    let path = get-history-path
    if not ($path | path exists) { [0, 0, 0, 0] | save -f $path }
    open $path | lines
}

def get-history-path []: nothing -> path {
    let pwd_hash = $env.PWD | hash md5
    $env.HOME | path join $'.cache/harpoon/($pwd_hash).txt'
}
