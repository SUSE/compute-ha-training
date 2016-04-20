#!/bin/bash

safely () {
    if ! "$@"; then
        echo >&2 "Aborting due to failure of: $*"
        exit 1
    fi
}

safely git branch -f gh-pages HEAD
safely git checkout gh-pages
safely sass --update --sourcemap css/reveal-override.scss
safely git add -f css/*.css css/*.map
safely git commit -m'Latest .css and .css.map files for publishing via gh-pages'
safely git push -f github-austin gh-pages
safely git checkout -
