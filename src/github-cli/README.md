
# GitHub CLI (with persistence) (github-cli)

Install GitHub CLI and configure it to store configuration in a mounted volume to preserve across container builds

## Example Usage

```json
"features": {
    "ghcr.io/koichirok/devcontainer-features/github-cli:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | GitHub CLI release version to install, such as '2.103.3' (without the 'v' prefix), or 'latest' to install the latest release | string | latest |

Installs GitHub CLI (`gh`) from the [GitHub CLI releases page](https://github.com/cli/cli/releases) and persists its configuration in `/dc/github-cli` (mounted as a volume) so that it survives container rebuilds.

## OS and Architecture Support

Architectures: amd64, arm64, armv6/armv7, 386

OS: Linux distributions such as Ubuntu, Debian, Alpine, Fedora, and Rocky Linux (the Docker tests cover these on amd64)

## Changelog

| Version | Notes                                                |
| ------- | ---------------------------------------------------- |
| 0.0.1   | Initial Version                                      |


---

_Note: This file was auto-generated from the [devcontainer-feature.json](devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
