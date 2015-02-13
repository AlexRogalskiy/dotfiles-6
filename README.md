it's just dotfiles‽

## bootstrap
mkdir -p ~/.dotfiles && cd ~/.dotfiles && curl -#L https://github.com/robertcboll/dotfiles/tarball/master | tar -xzv --strip-components 1 -C ~/.dotfiles && ~/.dotfiles/bootstrap.sh
