#!/usr/bin/env bash

set -e

# Import test library bundled with the devcontainer CLI (provides `check` and `reportResults`)
# shellcheck source=/dev/null
source dev-container-features-test-lib

# Feature-specific tests
check "GitLab CLI installed" bash -c "command -v glab"
check "GitLab CLI runs" bash -c "glab --version"
# shellcheck disable=SC2016 # expansion is intended to happen in the inner bash, not here
check "GLAB_CONFIG_DIR is set" bash -c 'test "$GLAB_CONFIG_DIR" = "/dc/gitlab-cli"'
check "cache dir permission" bash -c "test -w /dc/gitlab-cli"
# shellcheck disable=SC2016 # expansion is intended to happen in the inner bash, not here
check "check symlink" bash -c 'test "$(readlink "$HOME/.config/glab-cli")" = "/dc/gitlab-cli"'

# Report result
reportResults
