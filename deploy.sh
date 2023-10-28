#!/usr/bin/env sh

is_help=false
is_dry_run=false
is_clean=false
is_parallel=false

while [ $# -gt 0 ]; do  # Check if total number of args is greater than 0
  key="$1"              # Get the first argument
  case $key in
    --help | -h)
      # Set the rebuild flag to true
      is_help=true
      ;;
    --dry-run)
      # Set the rebuild flag to true
      is_dry_run=true
      ;;
    --clean)
      # Set the rebuild flag to true
      is_clean=true
      ;;
    --parallel | -p)
      # Set the rebuild flag to true
      is_parallel=true
      ;;
    # *)
    #   # Assume any other argument is a filename
    #   input="$1"
    #   ;;
  esac
  # Shift the arguments to the left
  shift
done

if [ "$is_help" = true ]; then
  printf "usage: $0 [options]\n"
  printf "\n"
  printf "options:\n"
  printf "  -h, --help        Show this menu.\n"
  printf "  --dry-run         Dry run the commands.\n"
  printf "  --clean           Clean the output directories build and pdfs before\n"
  printf "                    compiling.\n"
  printf "  -p, --parallel    Compile in parallel using parallel.\n"
  exit 0
fi

if [ "$is_clean" = true ]; then
  rm -rf build
  rm -rf pdfs
fi

mkdir -p build

# Build pdfs
# Add files
printf "" > build/tmp
find "./analysb" | grep .tex >> build/tmp
echo "./calcmem.tex" >> build/tmp

# Compile
printf "Compiling pdfs\n"
count=$(cat build/tmp | wc -l)
files=$(cat build/tmp)
args="--no-spin --no-output"
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
printf "Create pdf directories\n"
mkdir -p pdfs
dirs=$(cat build/tmp | sed -E "s/(.*)(\/.*)/\1/" | sort | uniq)
for dir in $dirs; do
  if [ "$is_dry_run" = true ]; then
    printf "mkdir pdfs/$dir\n"
  else
    mkdir -p "pdfs/$dir"
  fi
done

printf "Copy compiled pdf to pdfs directory\n"
pdfs=$(cat build/tmp | sed -E "s/(.*)\.tex/\1.pdf/")
for pdf in $pdfs; do
  outdir=$(printf "$pdf\n" | sed -E "s/(.*)(\/.*)/\1/")
  if [ "$is_dry_run" = true ]; then
    printf "cp build/$pdf -> pdfs/$dir\n"
  else
    cp "build/$pdf" "pdfs/$outdir"
  fi
done

