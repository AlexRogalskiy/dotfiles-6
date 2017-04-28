#! /usr/bin/env bash
set -euo pipefail

setup() {
    apt-get update
    apt-get install -y vim

    apt-get autoremove --purge
}

configure() {
    echo "no configure on debian"
}
