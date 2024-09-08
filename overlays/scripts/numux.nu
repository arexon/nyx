const SEP = "\t"

def main []: nothing -> nothing {
    let session = {
        name: main
        path: $env.HOME
    }
    create-session-if-not-exists $session
    ^tmux attach-session -t $session.name
}

def "main switch-workspace" []: nothing -> nothing {
    let session = fuzzy-find "Switch to a workspace"
    switch-to-or-create-session $session
}

def "main delete-workspace" []: nothing -> nothing {
    let session = fuzzy-find "Delete a workspace"
    delete-session $session.name
}

def sessions []: nothing -> table {
    ^tmux list-sessions
    | lines
    | parse "{name}: {windows} windows (created {date}){attached}"
    | into int windows
    | into datetime date
    | update attached {|it| $it.attached != ""}
}

def fuzzy-find [header: string]: nothing -> record<name: string, path: string> {
    workspaces
    | serialize-workspaces
    | ^fzf --header $" ($header)" --delimiter $SEP --with-nth 3
    | if ($in | is-empty) { exit } else { $in }
    | split row $SEP
    | { name: $in.0, path: $in.1 }
}

def workspaces []: nothing -> table {
    let search_paths = [
        $env.HOME
        ($env.HOME + "/nyx")
        (ls ~/projects | get name)
    ] | flatten

    $search_paths
    | par-each {|path|
        let name = $path
            | path basename
            | if $in == $env.USER { "main" } else { $in }

        let workspace = {
            name: $name
            path: $path
            windows: 0
            date: null
            attached: false
        }

        sessions | reduce -f $workspace {|session, acc|
            if $session.name == $acc.name {
                $acc | merge $session
            } else {
                $acc
            }
        }
    }
    | sort-by date
}

def serialize-workspaces []: table -> string {
    each {|wp|
        let windows = if $wp.windows > 0 { $"[($wp.windows)] " } else { "" }
        let date = if $wp.date != null { $wp.date | date humanize } else { "" }
        let attached = if $wp.attached { "*" } else { "" }
        $wp.name + $SEP + $wp.path + $SEP + $attached + $wp.name + $windows + $date
    } | to text
}

def switch-to-or-create-session [session: record<name: string, path: string>]: nothing -> nothing {
    create-session-if-not-exists $session

    ^tmux switch-client -t $session.name
}

def create-session-if-not-exists [session: record<name: string, path: string>]: nothing -> nothing {
    if $session.name not-in (sessions | get name) {
        ^tmux new-session -ds $session.name -c $session.path
    }
}

def delete-session [session: string]: nothing -> nothing {
    ^tmux kill-session -t $session
}
