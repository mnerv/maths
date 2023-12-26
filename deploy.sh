#!/usr/bin/env sh

# Configs
registry_name="registry"
registry_path=""
registry_cache_path=""
build_dir="build"
dist_dir="dist"
cache_uri=""
root_dir=$(pwd)

# State flags
is_cached=false
# -------------
is_dry_run=false
is_clean=false
is_parallel=false
is_production=false
is_skip_load_cache=false

help() {
  printf "usage: $arg0 [options]\n"
  printf "\n"
  printf "options:\n"
  printf "    -h, --help          Show this menu.\n"
  printf "    --dry-run           Dry run the commands.\n"
  printf "    --clean             Clean the output directories build and pdfs\n"
  printf "                        before compiling.\n"
  printf "    --parallel          Use parallel to run the compile scripts.\n"
  printf "    --production        Create pdf in distribution directory.\n"
  printf "    --build-dir         Specify build directory,\n"
  printf "                        example: --build-dir=\"build\". Default: build.\n"
  printf "    --dist-dir          Specify dist directory,\n"
  printf "                        example: --dist-dir=\"dist\". Default: dist.\n"
  printf "    --cache-uri         Set cache uri to download.\n"
  printf "    --skip-load-cache   Skip loading cache.\n"
}

generate_file_index() {
  # Add files
  printf "" > $registry_path
  find ./analys_b | grep .tex >> $registry_path
  find ./linjär_algebra | grep .tex >> $registry_path
  find ./misc | grep .tex >> $registry_path

  # Filter out dependencies from registry database
  registry_data=$(cat $registry_path | sort)
  input_deps=""

  for path in $registry_data
  do
    input_dep=$(egrep '\\input\{.+\}' $path | sed -e 's/\\input{\(.*\)}/\1/g')
    if ! [[ -z "$input_dep" ]]; then
      if ! [[ -z "$input_deps" ]]; then
        input_deps="$input_deps\n$input_dep"
      else
        input_deps="$input_dep"
      fi
    fi
  done

  input_deps=$(printf "$input_deps\n" | sort -u)
  for path in $input_deps
  do
    esc_path=$(printf "$path\n" | sed -r 's/\//\\\//')
    registry_data=$(printf "$registry_data\n" | sed -r "s/^.*$esc_path//")
  done

  printf "$registry_data\n" | sort -u | sed -r '/^\s*$/d' > $registry_path
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
      --help | -h)
        help
        exit 0
        ;;
      --dry-run)
        is_dry_run=true
        ;;
      --clean)
        is_clean=true
        ;;
      --parallel)
        is_parallel=true
        ;;
      --production)
        is_production=true
        ;;
      --build-dir=*)
        build_dir="${key#*=}"
        ;;
      --dist-dir=*)
        dist_dir="${key#*=}"
        ;;
      --cache-uri=*)
        cache_uri="${key#*=}"
        ;;
      --skip-load-cache)
        is_skip_load_cache=true
        ;;
      *)
        printf "Unsupported argument: $key\n"
        exit 1
      ;;
    esac
    shift
  done
}

prebuild() {
  # clean
  if [[ $is_clean = true ]] && [[ -e "$build_dir" ]]; then
    rm -rf $build_dir 
  fi
  if [[ $is_clean = true ]] && [[ $is_production = true ]] && [[ -e "$dist_dir/pdf" ]]; then
    rm -rf "$dist_dir/pdf"
  fi

  # create path
  if ! [[ -e $build_dir ]]; then
    mkdir -p $build_dir
  fi

  # construct path strings
  registry_path="$build_dir/$registry_name.txt"
  registry_cache_path="$build_dir/$registry_name.cache.txt"

  # check for cache
  if [[ $is_skip_load_cache = true ]]; then
    return 0
  fi

  if [[ -z $cache_uri ]]; then
    cd $build_dir
    wget $cache_uri
    cd $root_dir
  fi

  # BUG: Removed LaTeX file won't be updated.
  if [[ -e "$build_dir/archive.tar.gz" ]]; then
    cd $build_dir
    tar -xzf "./archive.tar.gz"
    cd $root_dir
  fi
}

build() {
  if ! [[ -e "$registry_path" ]]; then
    printf "No registry file\n"
    exit 1
  fi

  files=$(cat $registry_path)
  args="--build-dir=$build_dir"

  if [[ $is_parallel = true ]]; then
     parallel --will-cite sh ./compile.sh $args ::: $files
  else
    for file in $files; do
      sh ./compile.sh $args $file
    done
  fi
}

postbuild() {
  cd $build_dir
  tar -czf archive.tar.gz pdf
  cd $root_dir

  if [[ $is_production = true ]]; then
    if ! [[ -e "$dist_dir" ]]; then
      mkdir -p "$dist_dir"
    fi

    if [[ -e "$dist_dir/pdf" ]]; then
      rm -rf "$dist_dir/pdf"
    fi

    cp -rf "$build_dir/pdf" "$dist_dir"
    cp "$registry_path" "$dist_dir/pdf"
    cp "$build_dir/archive.tar.gz" "$dist_dir/pdf"
  fi
}

parse_args $@
prebuild
generate_file_index
build
postbuild

