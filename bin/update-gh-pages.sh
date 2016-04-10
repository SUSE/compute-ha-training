#!/bin/bash

safely () {
    if ! "$@"; then
        echo >&2 "Aborting due to failure of: $*"
        exit 1
    fi
}

safely git checkout gh-pages
safely git reset --hard SUSE-theme
safely sass --update --sourcemap css
safely git add -f css/*.css css/*.map
safely git commit -m'Latest .css and .css.map files for publishing via gh-pages'
safely git push -f github gh-pages
safely git checkout -
