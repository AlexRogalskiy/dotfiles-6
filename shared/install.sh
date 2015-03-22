#! /bin/bash

echo "configuring shared components"

# stow app dirs
stows=(bash git psql sbt ssh vim)

pushd . &>/dev/null

cd shared
for dir in ${stows[@]}; do
	stow --adopt -t ~ $dir
done;

popd &>/dev/null

# pulling pubkeys from github
curl https://github.com/robertcboll.keys >> ~/.ssh/authorized_keys &>/dev/null
