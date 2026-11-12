#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "GitHub CLI installed on Alpine" bash -c "gh --version"
check "Alpine image" bash -c ". /etc/os-release && test \"\$ID\" = alpine"

reportResults
