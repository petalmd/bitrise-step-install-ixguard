#!/bin/bash
set -e

REQUIRED_VERSION=${version}
SSH_KEY_FILE_URL=${ssh_key_file}
SSH_KEY_PASSPHRASE=${ssh_key_passphrase}
PLATFORM=${platform}



KEY_PATH="$HOME/.ssh/protected_ixguard_key"

if [ "$PLATFORM" == "android" ]; then
    PLATFORM_FLAG="--android"
elif [ "$PLATFORM" == "ios" ]; then
    PLATFORM_FLAG="--ios"
else
    echo "Invalid platform. Supported platforms are android and ios."
    exit 1
fi

# Download and install the ssh key for Guardsquare access given url and passphrase are defined
if [ -n "$SSH_KEY_FILE_URL" ] && [ -n "$SSH_KEY_PASSPHRASE" ]; then
    mkdir -p "$HOME/.ssh"

    curl -fSL "$SSH_KEY_FILE_URL" -o "$KEY_PATH"
    chmod 600 "$KEY_PATH"

    eval "$(ssh-agent -s)"

    expect <<EOF
set timeout -1
spawn ssh-add "$KEY_PATH"
expect "Enter passphrase for"
send "$SSH_KEY_PASSPHRASE\r"
expect eof
EOF

else
    echo "SSH key for iXGuard access is missing."
    exit 1
fi

# Check if desired version of ixguard, otherwise use default
if [ -z "$REQUIRED_VERSION" ]; then
    echo "No version set. Selecting default version 4.15.1"
    REQUIRED_VERSION="4.15.1"
fi

if ! command -v ixguard >/dev/null 2>&1 || [[ "$(ixguard --version)" != *"$REQUIRED_VERSION"* ]]; then
    echo "Guuardsquare not found or incorrect version. Installing version $REQUIRED_VERSION..."

    if ! command -v guardsquare >/dev/null 2>&1; then
        echo "Downloading guardsquare..."

        # Download and install guardsquare CLI
        curl -sS https://platform.guardsquare.com/cli/install.sh | sh -s -- --yes
    fi

    if [ "$PLATFORM" == "ios" ]; then
        # Download and install ixguard package
        guardsquare download --ssh-agent ixguard@$REQUIRED_VERSION -o ixguard.pkg
        sudo installer -pkg ixguard.pkg -target /
    fi
else
    echo "iXGuard $REQUIRED_VERSION is already installed."
fi

exit 0
