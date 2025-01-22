def main []: nothing -> nothing {}

def 'main list' []: nothing -> string {
    get-history | to text
}

def 'main switch' [n: number]: nothing -> nothing {
    let data = get-history | get ($n - 1)
    ^tmux send-keys $':o ($data)' C-m
}

def 'main set' [n: number]: nothing -> nothing {
    get-history
    | enumerate
    | each {|it| if $it.index == ($n - 1) { get-status } else { $it.item } }
    | save -f (get-history-path)
}

def 'main update' []: nothing -> nothing {
    let status = get-status
    let file_path = $status | split row ':' | get 0
    get-history
    | each {|it|
        if ($it | split row ':' | get 0) == $file_path { $status }
        else { $it }
    }
    | save -f (get-history-path)
}

def get-status []: nothing -> string {
    ^tmux capture-pane -p
    | ^rg -o '( NOR| INS)\s+([^\s]+).*?(\d+):(\d+)' --only-matching --replace '$2:$3:$4'
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
