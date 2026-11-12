
# GitLab CLI (with persistence) (gitlab-cli)

Install GitLab CLI and configure it to store configuration in a mounted volume to preserve across container builds

## Example Usage

```json
"features": {
    "ghcr.io/koichirok/devcontainer-features/gitlab-cli:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | GitLab CLI release version to install, such as '1.130.0' (without the 'v' prefix), or 'latest' to install the latest release | string | latest |

Installs GitLab CLI (`glab`) from the [GitLab CLI releases page](https://gitlab.com/gitlab-org/cli/-/releases) and persists its configuration in `/dc/gitlab-cli` (mounted as a volume) so that it survives container rebuilds.

## OS and Architecture Support

Architectures: amd64, arm64, armv6/armv7, 386, ppc64le, s390x

OS: Linux distributions such as Ubuntu, Debian, Alpine, Fedora, and Rocky Linux (the Docker tests cover these on amd64)

## Changelog

| Version | Notes                                                |
| ------- | ---------------------------------------------------- |
| 0.0.1   | Initial Version                                      |


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/koichirok/devcontainer-features/blob/main/src/gitlab-cli/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
