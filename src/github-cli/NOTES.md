Installs GitHub CLI (`gh`) from the [GitHub CLI releases page](https://github.com/cli/cli/releases) and persists its configuration in `/dc/github-cli` (mounted as a volume) so that it survives container rebuilds.

## OS and Architecture Support

Architectures: amd64, arm64, armv6/armv7, 386

OS: Linux distributions such as Ubuntu, Debian, Alpine, Fedora, and Rocky Linux (the Docker tests cover these on amd64)

## Changelog

| Version | Notes                                                |
| ------- | ---------------------------------------------------- |
| 0.0.1   | Initial Version                                      |
