#! /bin/bash

pushd "$(dirname "${BASH_SOURCE}")/.." >/dev/null

# stow app dirs
stows=(bash git intellij iterm2 psql sbt ssh vim)

for dir in ${stows[@]}; do
	stow --adopt -t ~ $dir
done;

popd &>/dev/null

vim +PluginInstall +GoInstallBinaries +qall

# pulling pubkeys from github
echo "pulling ssh keys from github"
curl -s https://github.com/robertcboll.keys > ~/.ssh/authorized_keys
