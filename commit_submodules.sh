#!/usr/bin/env bash

COMMIT_MESSAGE="${1:-auto}"
git submodule foreach "echo 'Adding all files.'; git add ."
git submodule foreach "echo 'Stashing.'; git stash"
git submodule foreach "echo 'Checking out master branch.'; git checkout master"
git submodule foreach "echo 'Applying stash.'; git stash apply"
git submodule foreach "echo 'Re-adding all files.'; git add ."
git submodule foreach "echo 'Committing changes.'; git commit -a -q -m '${COMMIT_MESSAGE}' || :"
echo 'Adding main repo changes.'
git add .
echo 'Committing changes to main repo.'
git commit -a -m "${COMMIT_MESSAGE}"
git push --recurse-submodules=on-demand
