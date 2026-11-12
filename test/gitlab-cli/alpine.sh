#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "GitLab CLI installed on Alpine" bash -c "glab --version | grep -F '1.130.0'"
check "Alpine image" bash -c ". /etc/os-release && test \"\$ID\" = alpine"

reportResults
