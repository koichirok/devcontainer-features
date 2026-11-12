#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "GitLab CLI pinned version" bash -c "glab --version | grep -F '1.130.0'"

reportResults
