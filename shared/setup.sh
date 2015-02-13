#! /bin/bash

echo "configuring shared apps"

# stow app dirs
stows=(bash git psql sbt ssh vim)

pushd . &>/dev/null

cd shared
for dir in ${stows[@]}; do
	stow --adopt -t ~ $dir
done;

popd &>/dev/null

curl https://github.com/robertcboll.keys >> ~/.ssh/authorized_keys &>/dev/null
