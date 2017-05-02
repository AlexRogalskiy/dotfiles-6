#! /usr/bin/env bash
set -euo pipefail

setup() {
    echo "deb http://deb.debian.org/debian testing main" | sudo tee /etc/apt/sources.list.d/testing.list

    sudo apt-get update
    sudo apt-get install -y stow git jq tree curl wget findutils coreutils ruby \
        vim neovim \
        python-dev python-pip \
        build-essential libssl-dev

    sudo curl -sL -o /usr/local/bin/gimme https://raw.githubusercontent.com/travis-ci/gimme/master/gimme
    sudo chmod +x /usr/local/bin/gimme

    sudo apt-get autoremove --purge
}

configure() {
    echo "no configure on debian"
}
