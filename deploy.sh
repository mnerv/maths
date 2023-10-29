#!/usr/bin/env sh

arg0=$0
is_help=false
is_dry_run=false
is_clean=false
is_parallel=false
is_production=false
build_dir=build
dist_directory=dist

while [ $# -gt 0 ]; do  # Check if total number of args is greater than 0
  key="$1"              # Get the first argument
  case $key in
    --help | -h)
      is_help=true
      ;;
    --dry-run)
      is_dry_run=true
      ;;
    --clean)
      is_clean=true
      ;;
    --parallel | -j)
      is_parallel=true
      ;;
    --production | -p)
      is_production=true
      ;;
    --dist-dir=*)
      dist_directory="${key#*=}"
      ;;
  esac
  # Shift the arguments to the left
  shift
done

index_registry="$build_dir/registry.txt"
pdflatex_directory="$build_dir/latex"
pdf_directory=$build_dir/pdf

if [ "$is_help" = true ]; then
  printf "usage: $arg0 [options]\n"
  printf "\n"
  printf "options:\n"
  printf "  -h, --help          Show this menu.\n"
  printf "  --dry-run           Dry run the commands.\n"
  printf "  --clean             Clean the output directories build and pdfs before\n"
  printf "                      compiling.\n"
  printf "  -j, --parallel      Compile in parallel using parallel.\n"
  printf "  -p, --production    Create pdf in distribution directory.\n"
  printf "  --dist-dir          Specify dist directory,\n"
  printf "                      example: --dist-dir=\"dist\". Default: dist.\n"
  exit 0
fi

exec_cmd() {
  local cmd=$1
  if [ "$is_dry_run" = false ] && ! [ -z "$cmd" ]; then
    eval $cmd
  else
    printf "$cmd\n"
  fi
}

if [ "$is_clean" = true ]; then
  exec_cmd "rm -rf $build_dir"
  exec_cmd "rm -rf $dist_directory"
fi

mkdir -p $build_dir
mkdir -p $pdflatex_directory

# Add files
printf "" > $index_registry
find ./analysb | grep .tex >> $index_registry
echo ./calcmem.tex >> $index_registry

printf "$(cat $index_registry)\n" | sort > $index_registry

# Compile
printf "Compiling pdfs to $pdflatex_directory\n"
count=$(cat $index_registry | wc -l)
files=$(cat $index_registry)
args="--no-spin --no-output --outdir=$pdflatex_directory"
if [ "$is_dry_run" = true ]; then
  args="${args} --dry-run"
fi

if [ "$is_parallel" = true ]; then
  parallel --will-cite sh ./compile.sh $args ::: $files
else
  for file in $files; do
    sh ./compile.sh $args $file
  done
fi


# Post cleanup
printf "Create final pdf directories\n"
mkdir -p $pdf_directory
dirs=$(cat $index_registry | sed -E "s/(.*)(\/.*)/\1/" | sort | uniq)
for dir in $dirs; do
  exec_cmd "mkdir -p \"$pdf_directory/$dir\""
done

printf "Copy compiled pdfs to $pdf_directory\n"
pdfs=$(cat $index_registry | sed -E "s/(.*)\.tex/\1.pdf/")
for pdf in $pdfs; do
  outdir=$(printf "$pdf\n" | sed -E "s/(.*)(\/.*)/\1/")
  exec_cmd "cp $pdflatex_directory/$pdf $pdf_directory/$outdir"
done

if [ "$is_production" = true ]; then
  mkdir -p $dist_directory
  cp -rf $pdf_directory $dist_directory
  cp $index_registry $dist_directory/pdf
fi

