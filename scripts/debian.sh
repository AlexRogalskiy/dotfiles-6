#! /usr/bin/env bash
set -euo pipefail

setup() {
    sudo apt-get update
    sudo apt-get install -y stow vim git jq tree wget findutils coreutils \
        python-pip ruby

    #TODO install nodejs
    curl -sL -o /usr/local/bin/gimme https://raw.githubusercontent.com/travis-ci/gimme/master/gimme
    chmod +x /usr/local/bin/gimme

    sudo apt-get autoremove --purge
}

configure() {
    echo "no configure on debian"
}
