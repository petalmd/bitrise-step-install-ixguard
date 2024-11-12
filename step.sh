#!/bin/bash
set -e

# Desired version of iXGuard
REQUIRED_VERSION=${version}

if [ -n "$REQUIRED_VERSION" ]; then
    REQUIRED_VERSION="4.12.6"
    echo "No version set. Selecting default version 4.12.6"
fi

if ! command -v ixguard >/dev/null 2>&1 || [[ "$(ixguard --version)" != *"$REQUIRED_VERSION"* ]]; then
    echo "iXGuard not found or incorrect version. Installing version $REQUIRED_VERSION..."

    if ! command -v guardsquare >/dev/null 2>&1; then
        echo "Downloading guardsquare..."
        # Download and install guardsquare CLI
        curl https://downloads.guardsquare.com/cli/latest_macos_amd64 -sL | tar -x && sudo mv -i guardsquare /usr/local/bin/
    fi

    # Download and install ixguard package
    guardsquare download --ssh-agent ixguard@$REQUIRED_VERSION -o ixguard.pkg
    sudo installer -pkg ixguard.pkg -target /
else
    echo "iXGuard $REQUIRED_VERSION is already installed."
fi

exit 0
