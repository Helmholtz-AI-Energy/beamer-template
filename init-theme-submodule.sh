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
template_repo_url=https://github.com/Helmholtz-AI-Energy/beamer-template.git
submod_dir=hai_beamer_template
remove=false
this=$(basename $0)


usage(){
    cat << EOF
usage:
    $this [-r] <talk_dir> [template_repo_url]

Initialize this repo as git submodule in another talk repo and set links.

    fonts           -> $submod_dir/fonts
    helmholtzai.sty -> $submod_dir/helmholtzai.sty
    logos           -> $submod_dir/logos
    theme           -> $submod_dir/theme

Also, we try to find beamerfontthemeserif.sty on your machine and set a link to
it in theme/.

This script will not create commits. After you ran it, manually do

    $ git add -A
    $ git commit -m "Add hai_beamer_template submodule"

You can also invert the action of this script and remove (-r flag) the
submodule and the created links. Again, no commits are made, so you can always
"git restore" things.

args:
    talk_dir : target dir where to create submodule and links
    template_repo_url : set different URL (e.g. to point to a fork of this repo)

options:
    -r : remove submodule

examples:

    Run from this repo
        $ cd /path/to/hai-beamer-template
        $ ./$this /path/to/my/talk/

    Run from <talk_dir>
        $ cd /path/to/my/talk
        $ /path/to/hai-beamer-template/$this ./

    Run from anywhere
        $ /path/to/hai-beamer-template/$this /path/to/my/talk

    Use another repo
        $ /path/to/hai-beamer-template/$this /path/to/my/talk git@github.com:user42/awesome-helmholtz-ai-beamer-template-fork.git
EOF
}


while getopts hr opt; do
    case $opt in
        h) usage; exit 0;;
        r) remove=true;;
        \?) exit 1;;
    esac
done
shift $((OPTIND - 1))

[ $# -eq 1 -o $# -eq 2 ] || err "only one or two args supported"

[ $# -eq 1 ] && talk_dir=$1
[ $# -eq 2 ] && talk_dir=$1 && template_repo_url=$2

talk_dir=$(abspath $talk_dir)
echo "talk_dir: $talk_dir"
echo "template_repo_url: $template_repo_url"

cd $talk_dir

if ! $remove; then
    if [ -e $submod_dir ]; then
        echo "$submod_dir exists, not adding submodule; delete and re-run script to force add"
    else
        git submodule add $template_repo_url $submod_dir
    fi
fi

for name in logos theme fonts helmholtzai.sty; do
    if $remove; then
        [ -e $name ] && git rm $name
    else
        [ -e $name ] || ln -vs hai_beamer_template/$name $name
    fi
done

if $remove; then
    # https://riptutorial.com/git/example/2652/removing-a-submodule
    if [ -e $submod_dir ]; then
        git submodule deinit $submod_dir
        git rm $submod_dir
    fi
    rm -rfv .git/modules/$submod_dir
else
    # This path works on Debian, so probably also Ubuntu. Add more paths to
    # check if needed or query locate(1).
    serif_sty_src=/usr/share/texlive/texmf-dist/tex/latex/beamer/beamerfontthemeserif.sty
    serif_sty_tgt=theme/beamerfontthemeserif.sty
    if [ -e $serif_sty_src ]; then
        [ -e $serif_sty_tgt ] || ln -vs $serif_sty_src $serif_sty_tgt
    fi
fi
