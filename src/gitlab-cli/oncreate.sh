#!/usr/bin/env bash

set -e

# Runs via onCreateCommand (once per container creation, per the dev container
# spec) to ensure the mounted volume backing ~/.config/glab-cli is writable by
# the remote user. All actions here must stay idempotent.

echo "In OnCreate script"

fix_permissions() {
    local dir
    dir="${1}"

    if [ -w "${dir}" ]; then
        echo "Permissions of '${dir}' are OK!"
        return 0
    fi

    echo "Fixing permissions of '${dir}'..."
    if [ "$(id -u)" -eq 0 ]; then
        chown -R "$(id -u):$(id -g)" "${dir}"
    elif command -v sudo >/dev/null 2>&1 && sudo -n true 2>/dev/null; then
        sudo chown -R "$(id -u):$(id -g)" "${dir}"
    else
        echo "WARNING: '${dir}' is not writable and sudo is not available (or requires a password)." >&2
        echo "WARNING: Skipping permission fix; glab may fail to write its config." >&2
        return 0
    fi
    echo "Done!"
}

fix_permissions "/dc/gitlab-cli"
echo "Done"
