# Math Notes

Alpine container with LaTeX and neovim installation.

## Build

```sh
docker build -t latex .
```

## Run

```sh
docker run -it -v "$(pwd):/home/porter/app" --hostname latex latex
```

