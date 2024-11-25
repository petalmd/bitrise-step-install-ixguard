#!/bin/bash
set -e

REQUIRED_VERSION=${version}
SSH_KEY_FILE_URL=${ssh_key_file}
SSH_KEY_PASSPHRASE=${ssh_key_passphrase}

# Download and install the ssh key for Guardsquare access given url and passphrase are defined
if [ -n "$SSH_KEY_FILE_URL" ] && [ -n "$SSH_KEY_PASSPHRASE" ]; then
    curl $SSH_KEY_FILE_URL -o "protected_ixguard_key"
    chmod 600 ./protected_ixguard_key

    eval "$(ssh-agent -s)"

    expect <<EOF
set timeout -1
spawn ssh-add "./protected_ixguard_key"
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
    echo "No version set. Selecting default version 4.12.6"
    REQUIRED_VERSION="4.12.6"
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
