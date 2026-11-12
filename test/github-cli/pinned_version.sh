#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "GitHub CLI pinned version" bash -c "gh --version | grep -F '2.103.3'"

reportResults
