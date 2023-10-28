# Math Notes

Alpine container with LaTeX and neovim installation.

## Build

Build docker image.

```sh
docker build -t latex .
```

## Run

Start latex docker image.

```sh
docker run -it --rm -v "$(pwd):/home/porter/app" --hostname latex --name maths latex
```

## Resources

  - Inner product space - <https://en.wikipedia.org/wiki/Inner_product_space>
  - Tensor - <https://en.wikipedia.org/wiki/Tensor>
  - Lissajous curve - <https://en.wikipedia.org/wiki/Lissajous_curve>

