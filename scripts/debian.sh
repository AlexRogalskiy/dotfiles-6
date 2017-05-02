#! /usr/bin/env bash
set -euo pipefail

setup() {
    sudo apt-get update && sudo apt-get install -y curl wget apt-transport-https

    echo "deb http://deb.debian.org/debian testing main" | sudo tee /etc/apt/sources.list.d/testing.list
    echo "deb https://deb.nodesource.com/node_7.x jessie main" | sudo tee /etc/apt/sources.list.d/nodesource.list

    curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -

    sudo apt-get update && sudo apt-get install -y xstow git jq tree \
        findutils coreutils \
        vim neovim \
        ruby nodejs \
        python-dev python-pip \
        build-essential libssl-dev

    sudo ln -sf /usr/bin/xstow /usr/local/bin/stow
    sudo curl -sL -o /usr/local/bin/gimme https://raw.githubusercontent.com/travis-ci/gimme/master/gimme
    sudo chmod +x /usr/local/bin/gimme

    eval `gimme 1.8`

    sudo apt-get autoremove --purge
}

configure() {
    echo ""
}
