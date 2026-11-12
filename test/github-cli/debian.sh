#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "GitHub CLI installed on Debian" bash -c "gh --version"
check "Debian image" bash -c ". /etc/os-release && test \"\$ID\" = debian"

reportResults
