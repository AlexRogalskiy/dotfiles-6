it's just dotfiles‽

## bootstrap
### ubuntu (installs curl)
echo "(apt output in /tmp/apt.log)"; sudo apt-get install -y curl >/tmp/apt.log; curl -fsSL https://raw.githubusercontent.com/robertcboll/dotfiles/master/bootstrap.sh > /tmp/bootstrap.sh && chmod +x /tmp/bootstrap.sh && /tmp/bootstrap.sh && rm /tmp/bootstrap.sh

### other (curl required)
curl -fsSL https://raw.githubusercontent.com/robertcboll/dotfiles/master/bootstrap.sh > /tmp/bootstrap.sh && chmod +x /tmp/bootstrap.sh && /tmp/bootstrap.sh && rm /tmp/bootstrap.sh
