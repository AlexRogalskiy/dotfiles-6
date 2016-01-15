#! /usr/bin/env bash
set -e

echo ">> Installing for apt-based system."

add-apt-repository -y ppa:openjdk-r/ppa
add-apt-repository -y ppa:neovim-ppa/unstable
add-apt-repository -y ppa:rael-gc/scudcloud
add-apt-repository -y ppa:ubuntu-lxc/lxd-stable

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

apt-get update

apt-get install -ym bash bash-completion \
    gparted hfsutils stow tmux coreutils exuberant-ctags encfs \
    neovim openjdk-8-jdk scudcloud \
    vim mercurial gist cmake python-dev python-pip python3-dev python3-pip nodejs npm golang-go scala \
    gradle leiningen maven ansible awscli \
    jq docker.io vagrant virtualbox shellcheck markdown \
    chromium-browser spotify-client visualvm fonts-inconsolata \
    gnome-screensaver touchegg

curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /tmp/chrome.deb && \
sudo dpkg -i /tmp/chrome.deb && rm /tmp/chrome.deb

curl https://dist.keybase.io/linux/deb/keybase-latest-amd64.deb -o /tmp/keybase.deb && \
sudo dpkg -i /tmp/keybase.deb && rm /tmp/keybase.deb

sudo -u roboll git clone https://github.com/roboll/elementary-dropbox /tmp/elementary-dropbox && \
sudo -u roboll /tmp/elementary-dropbox/install.sh -y && \
rm -r /tmp/elementary-dropbox
