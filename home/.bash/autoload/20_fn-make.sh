#!/usr/bin/env bash

# parallelize make by default
function make() {
    /usr/bin/make -j "$@"
}
