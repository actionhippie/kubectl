# kubectl

[![Current Tag](https://img.shields.io/github/v/tag/actionhippie/kubectl?sort=semver)](https://github.com/actionhippie/kubectl) [![Docker Build](https://github.com/actionhippie/kubectl/workflows/docker/badge.svg)](https://github.com/actionhippie/kubectl/actions/workflows/docker.yml)

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

Generally we are following [conventional commits][commits] when we apply
changes. That way we are able to generate proper changelogs for every release.
Please use always pull requests to integrate new functionalities or to fix
issues.

For the release process we are following [semantic versioning][semver] which
clearly indicates if a new version just resolves bugs, includes new features or
even includes breaking changes.

After installing the tools via `mise install` as described above set up the
pre-commit hooks so they run automatically on every commit:

```console
prek install --hook-type pre-commit --hook-type commit-msg
```

> `prek` is managed by mise and will be available after `mise install`.

If you have changed something on the source you should simply commit following
the mentioned conventions:

```console
git checkout -b feat/new-feature
git add --all
git commit -m 'feat: added awesome new feature'
git push --set-upstream origin feat/new-feature
```

After pushing your changes into the Git repository you should create a pull
request on GitHub. If the pull request have been merged and everything built
fine it will also create automatically a new release at least once a week.

## Authors

*   [Thomas Boerger](https://github.com/tboerger)

## License

Apache-2.0

## Copyright

```console
Copyright (c) 2022 Thomas Boerger <thomas@webhippie.de>
```

[mise]: https://mise.jdx.dev/
[mise-install]: https://mise.jdx.dev/getting-started.html
[commits]: https://www.conventionalcommits.org/en/v1.0.0/
[semver]: https://semver.org/
