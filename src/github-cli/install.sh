#!/bin/sh
set -e

FEATURE_ID="github-cli"
LIFECYCLE_SCRIPTS_DIR="/usr/local/share/devcontainer-features/${FEATURE_ID}/scripts"

fatal() {
    echo "$1" >&2
    exit 1
}

if [ -z "${_REMOTE_USER:-}" ]; then
    fatal "_REMOTE_USER is not set"
fi

if ! id -u "$_REMOTE_USER" >/dev/null 2>&1; then
    fatal "User '$_REMOTE_USER' does not exist"
fi

create_cache_dir() {
    cache_dir=$1

    if [ -d "$cache_dir" ]; then
        echo "Cache directory $cache_dir already exists. Skip creation..."
    else
        echo "Create cache directory $cache_dir..."
        mkdir -p "$cache_dir"
    fi

    echo "Change owner of $cache_dir to $_REMOTE_USER..."
    chown -R "$_REMOTE_USER:$_REMOTE_USER" "$cache_dir"
}

create_symlink_dir() {
    local_dir=$1
    cache_dir=$2
    parent_dir=$(dirname "$local_dir")

    if [ ! -d "$parent_dir" ]; then
        mkdir -p "$parent_dir"
        chown "$_REMOTE_USER:$_REMOTE_USER" "$parent_dir"
    fi

    # if the folder we want to symlink already exists, the ln -s command will create a folder inside the existing folder
    if [ -e "$local_dir" ]; then
        echo "Moving existing $local_dir folder to $local_dir-old"
        mv "$local_dir" "$local_dir-old"
    fi

    echo "Symlink $local_dir to $cache_dir for $_REMOTE_USER..."
    ln -s "$cache_dir" "$local_dir"
}

ensure_curl() {
    if command -v curl >/dev/null 2>&1; then
        return
    fi

    echo "curl is not installed; installing it..."
    if command -v apt-get >/dev/null 2>&1; then
        apt-get update
        apt-get install -y --no-install-recommends curl ca-certificates
        rm -rf /var/lib/apt/lists/*
    elif command -v apk >/dev/null 2>&1; then
        apk add --no-cache curl ca-certificates
    elif command -v dnf >/dev/null 2>&1; then
        dnf install -y curl ca-certificates
    elif command -v yum >/dev/null 2>&1; then
        yum install -y curl ca-certificates
    else
        echo "Cannot install curl: no supported package manager found" >&2
        exit 1
    fi
}

install_github_cli() {
    ensure_curl

    version=${VERSION:-latest}
    system=$(uname -s)
    machine=$(uname -m)

    if [ "$system" != "Linux" ]; then
        fatal "Unsupported operating system: $system (GitHub CLI feature requires Linux)"
    fi

    case "$machine" in
        x86_64|amd64) architecture=amd64;;
        aarch64|arm64) architecture=arm64;;
        armv6l|armv7l) architecture=armv6;;
        i386|i486|i586|i686) architecture=386;;
        *) fatal "Unsupported architecture: $machine";;
    esac

    if [ "$version" = "latest" ]; then
        # Resolve the latest version from the release page redirect instead of
        # the GitHub API, which is rate-limited for unauthenticated requests
        effective_url=$(curl -fsSLI --retry 3 -o /dev/null -w '%{url_effective}' \
            "https://github.com/cli/cli/releases/latest")
        version=${effective_url##*/}
        version=${version#v}
        if [ -z "$version" ] || [ "$version" = "latest" ]; then
            fatal "Unable to determine the latest GitHub CLI release version"
        fi
    else
        version=${version#v}
    fi

    case "$version" in
        '' | *[!0-9A-Za-z.+-]*) fatal "Invalid GitHub CLI version: $version";;
        [0-9]*) ;;
        *) fatal "Invalid GitHub CLI version: $version";;
    esac

    archive_name="gh_${version}_linux_${architecture}.tar.gz"
    download_url="https://github.com/cli/cli/releases/download/v${version}/${archive_name}"
    temp_dir=$(mktemp -d)
    trap 'rm -rf "$temp_dir"' EXIT

    echo "Downloading GitHub CLI ${version} for linux/${architecture}..."
    curl -fsSL --retry 3 "$download_url" -o "$temp_dir/gh.tar.gz"
    tar -xzf "$temp_dir/gh.tar.gz" -C "$temp_dir" "gh_${version}_linux_${architecture}/bin/gh"
    install -m 0755 "$temp_dir/gh_${version}_linux_${architecture}/bin/gh" /usr/local/bin/gh
}

echo "Activating feature 'github-cli'"
echo "User: ${_REMOTE_USER}     User home: ${_REMOTE_USER_HOME}"

echo "Installing GitHub CLI..."
install_github_cli
echo "GitHub CLI installed"

create_cache_dir "/dc/github-cli"
create_symlink_dir "$_REMOTE_USER_HOME/.config/gh" "/dc/github-cli"

# Set Lifecycle scripts
if [ -f oncreate.sh ]; then
    mkdir -p "${LIFECYCLE_SCRIPTS_DIR}"
    cp oncreate.sh "${LIFECYCLE_SCRIPTS_DIR}/oncreate.sh"
fi

echo "Finished installing $FEATURE_ID"
