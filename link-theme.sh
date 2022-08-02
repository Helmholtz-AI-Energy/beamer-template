#!/bin/sh

set -eu

err(){
    echo "error: $@"
    exit 1
}

# absolute path, but don't follow links
abspath(){
    realpath -s $1
}

# defaults
template_dir=$(abspath $(dirname $0))
simulate=false
this=$(basename $0)


usage(){
    cat << EOF
usage:
    $this [-s] [<template_dir>] <talk_dir>

Link <template_dir>'s main components into another <talk_dir>. With
<template_dir>=/path/to/hai-beamer-template :

    fonts           -> /path/to/hai-beamer-template/fonts
    helmholtzai.sty -> /path/to/hai-beamer-template/helmholtzai.sty
    logos           -> /path/to/hai-beamer-template/logos
    theme           -> /path/to/hai-beamer-template/theme

Also, we try to find beamerfontthemeserif.sty on your machine and set a link to
it in theme/.

args:
    template_dir : path to template repo, default is the path to this
        script [$template_dir]
    talk_dir : target dir where to create links

options:
    -s : simulate

examples:

    Run from <template_dir>, use default <template_dir>
        $ cd /path/to/hai-beamer-template
        $ ./$this /path/to/my/talk/

    Run from <talk_dir>, use default <template_dir>
        $ cd /path/to/my/talk
        $ /path/to/hai-beamer-template/$this ./

    Run from anywhere, also use default <template_dir>
        $ /path/to/hai-beamer-template/$this /path/to/my/talk

    Run from anywhere, but target another <template_dir> (rather unusual
    but possible)
        $ /path/to/hai-beamer-template/$this /path/to/other/template /path/to/my/talk

EOF
}


while getopts hs opt; do
    case $opt in
        h) usage; exit 0;;
        s) simulate=true;;
        \?) exit 1;;
    esac
done
shift $((OPTIND - 1))

[ $# -eq 1 -o $# -eq 2 ] || err "only one or two args supported"

[ $# -eq 1 ] && talk_dir=$1
[ $# -eq 2 ] && template_dir=$1 && talk_dir=$2

echo "template_dir: $template_dir"
echo "talk_dir    : $talk_dir"

for name in fonts helmholtzai.sty logos theme; do
    link_target=$(abspath $template_dir/$name)
    link_name=$(abspath $talk_dir/$name)
    [ -e $link_target ] || err "link target not found: $link_target"
    if [ -e $link_name ]; then
        [ -L $link_name ] || err "'$link_name' exists but is no link, won't replace"
    fi
    echo "link $link_name -> $link_target"
    if ! $simulate; then
        rm -vf $link_name
        ln -s $link_target $link_name
    fi
done

# This path works on Debian, so probably also Ubuntu. Add more paths to
# check if needed or query locate(1).
serif_sty_src=/usr/share/texlive/texmf-dist/tex/latex/beamer/beamerfontthemeserif.sty
serif_sty_tgt=theme/beamerfontthemeserif.sty
if [ -e $serif_sty_src ]; then
    [ -e $serif_sty_tgt ] || ln -vs $serif_sty_src $serif_sty_tgt
fi
