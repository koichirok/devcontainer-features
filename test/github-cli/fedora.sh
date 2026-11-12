#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "GitHub CLI installed on Fedora" bash -c "gh --version"
check "Fedora image" bash -c ". /etc/os-release && test \"\$ID\" = fedora"

reportResults
