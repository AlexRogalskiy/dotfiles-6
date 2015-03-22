it's just dotfiles‽

## bootstrap
### ubuntu (installs git and curl)
sudo apt-get install -y curl git && curl -fsSL https://raw.githubusercontent.com/robertcboll/dotfiles/master/bootstrap.sh > /tmp/bootstrap.sh && chmod +x /tmp/bootstrap.sh && /tmp/bootstrap.sh && rm /tmp/bootstrap.sh

### other (git and curl installed)
curl -fsSL https://raw.githubusercontent.com/robertcboll/dotfiles/master/bootstrap.sh > /tmp/bootstrap.sh && chmod +x /tmp/bootstrap.sh && /tmp/bootstrap.sh && rm /tmp/bootstrap.sh
