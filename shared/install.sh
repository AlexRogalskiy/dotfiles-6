#! /bin/bash

# stow app dirs
stows=(bash git psql sbt ssh vim)

pushd . &>/dev/null

cd shared
for dir in ${stows[@]}; do
	stow --adopt -t ~ $dir
done;

popd &>/dev/null

vim +PluginInstall +qall

# pulling pubkeys from github
echo "pulling ssh keys from github"
curl -s https://github.com/robertcboll.keys > ~/.ssh/authorized_keys
