#! /bin/bash

pushd "$(dirname "${BASH_SOURCE}")/../src" >/dev/null

stows=($(ls -d */))
for dir in "${stows[@]}"; do
	stow --adopt -t ~ "$dir"
done;

popd &>/dev/null

# ensure gopath is set
if [ -f ~/.bash_settings ]; then
    source ~/.bash_settings
fi
vim !silent +PluginInstall +GoInstallBinaries +qall

echo "pulling ssh pubkeys from github"
curl -s https://github.com/roboll.keys > ~/.ssh/authorized_keys
