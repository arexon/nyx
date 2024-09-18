watch ~/Pictures/Screenshots {|op, path|
    if ($op == "Create") {
        let filename = $path | path parse | update parent "screenshots" | update stem (random chars --length 16) | path join
        s3cmd put $path $"s3://filez/($filename)"
        $"https://filez.arexon.dev/($filename)" | xclip -selection clipboard
    }
}
