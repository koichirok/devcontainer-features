#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "GitHub CLI installed on Rocky Linux" bash -c "gh --version"
check "Rocky Linux image" bash -c ". /etc/os-release && test \"\$ID\" = rocky"

reportResults
