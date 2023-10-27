#!/usr/bin/env sh

# Check if file is given
if [ -z "$1" ]; then
    printf "usage: $0 <file.tex>\n"
    exit 1
fi

input=$1
filename="$(basename "$input")"     # filename with extension
filename_noext=${filename%.*}       # filename no extension
outdir=build/"$(dirname "$input")"  # construct output directory

spin() {
    sp='-\|/'
    while :
    do
        printf "\rcompiling $1: ${sp:0:1}"
        sp=${sp:1}${sp:0:1}
        sleep 0.1
    done
}

info() {
    printf "\r"
    if [ $1 -ne 0 ]; then
        printf "\rcompiling $2: failed, check build/$2.log\n"
        cat build/$2.log | awk 'BEGIN{IGNORECASE = 1}/warning|!/,/^$/;'
        exit 1
    else
        printf "\rcompiling $2: done\n"
    fi
}

run() {
    stage=$1
    cmd=$2

    spin "$stage" &
    spin_pid=$!
    $cmd > build/$stage.log
    exit_code=$?
    kill $spin_pid
    info $exit_code "$stage"
}

if [ ! -f "$input" ]; then
    printf "error: $input does not exist\n"
    exit 1
fi

mkdir -p $outdir
run "stage0" "pdflatex -halt-on-error -output-directory=$outdir $input"
run "stage1" "biber $outdir/$filename_noext"
run "stage2" "pdflatex -halt-on-error -output-directory=$outdir $input"

