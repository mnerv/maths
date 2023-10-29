#!/usr/bin/env sh

arg0=$0
is_help=false
is_output=true
is_no_spin=false
is_dry_run=false

usage_info() {
  printf "usage: $arg0 [options] <file.tex>\n"
  printf "\n"
  printf "options:\n"
  printf "  -h, --help   Show this menu.\n"
  printf "  --dry-run    Dry run the commands.\n"
  printf "  --no-output  Don't output stage logs.\n"
  printf "  --no-spin    No spin animations.\n"
}

# Check if file is given
if [ -z "$1" ]; then
  usage_info
  exit 1
fi

while [ $# -gt 0 ]; do  # Check if total number of args is greater than 0
  key="$1"      # Get the first argument
  case $key in
    --help | -h)
      is_help=true
      ;;
    --no-output | -no)
      # Set the rebuild flag to true
      is_output=false
      ;;
    --no-spin | -ns)
      # Set the rebuild flag to true
      is_no_spin=true
      ;;
    --dry-run)
      # Set the rebuild flag to true
      is_dry_run=true
      ;;
    *)
      # Assume any other argument is a filename
      input="$1"
      ;;
  esac
  # Shift the arguments to the left
  shift
done

if [ "$is_help" = true ]; then
  usage_info
  exit 0
fi

# Check if the filename variable is empty
if [ -z "$input" ]; then
  printf "Error: No filename provided.\n"
  usage_info
  exit 1
fi

if [ ! -f "$input" ]; then
  printf "error: $input does not exist\n"
  exit 1
fi

filename="$(basename "$input")"   # filename with extension
filename_noext=${filename%.*}   # filename no extension
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

  log_file=/dev/null
  if [ "$is_output" = true ]; then
    log_file=./build/$stage.log
  fi

  if [ "$is_no_spin" = true ]; then
    $cmd > $log_file
  else
    spin "$stage" &
    spin_pid=$!
    $cmd > $log_file
    exit_code=$?
    kill $spin_pid
    info $exit_code "$stage"
  fi
}

mkdir -p $outdir
if [ "$is_no_spin" = true ] && [ "$is_dry_run" = false ]; then
  printf "compiling $input..."
fi
if [ "$is_dry_run" = true ]; then
  printf "compiling $input\n"
else
  run "stage0" "pdflatex -halt-on-error -output-directory=$outdir $input"
  run "stage1" "biber $outdir/$filename_noext"
  run "stage2" "pdflatex -halt-on-error -output-directory=$outdir $input"
fi
if [ "$is_no_spin" = true ] && [ "$is_dry_run" = false ]; then
  printf "done!\n"
fi

