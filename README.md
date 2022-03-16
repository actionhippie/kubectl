# kubectl

[![Current Tag](https://img.shields.io/github/v/tag/actionhippie/kubectl?sort=semver)](https://github.com/actionhippie/kubectl) [![Docker Build](https://github.com/actionhippie/kubectl/workflows/docker/badge.svg)](https://github.com/actionhippie/kubectl/actions?query=workflow%3Adocker)

[GitHub Action](https://github.com/features/actions) to apply Kubernetes manifests.

## Usage

```yml
name: Example

on:
  - push
  - pull_request

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2

      - uses: actionhippie/kubectl@v1
        with:
          config: ${{ secrets.KUBE_CONFIG }}
          args: get all
```

## Inputs

### `config`

Kubeconfig in base64 encoded format

### `namespace`

The namespace to add to the command

### `args`

All arguments to append to kubectl

### `content`

Optional content to be piped into kubectl

## Outputs

None

## Security

If you find a security issue please contact thomas@webhippie.de first.

## Contributing

Fork -> Patch -> Push -> Pull Request

## Authors

* [Thomas Boerger](https://github.com/tboerger)

## License

Apache-2.0

## Copyright

```console
Copyright (c) 2022 Thomas Boerger <thomas@webhippie.de>
```
