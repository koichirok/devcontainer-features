#!/usr/bin/env bash

set -e

# Import test library bundled with the devcontainer CLI (provides `check` and `reportResults`)
# shellcheck source=/dev/null
source dev-container-features-test-lib

# Feature-specific tests
check "GitHub CLI installed" bash -c "command -v gh"
check "GitHub CLI runs" bash -c "gh --version"
# shellcheck disable=SC2016 # expansion is intended to happen in the inner bash, not here
check "GH_CONFIG_DIR is set" bash -c 'test "$GH_CONFIG_DIR" = "/dc/github-cli"'
check "cache dir permission" bash -c "test -w /dc/github-cli"
# shellcheck disable=SC2016 # expansion is intended to happen in the inner bash, not here
check "check symlink" bash -c 'test "$(readlink "$HOME/.config/gh")" = "/dc/github-cli"'

# Report result
reportResults
