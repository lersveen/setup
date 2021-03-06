
# Homebrew setup

## 1. Installation
```
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## 2. Install all packages
```
$ xargs brew install < ~/setup/brew/brewlist.txt
```
- You might want to check if you need all of them

## 3. Automatic updates
1.  Install [Homebrew-autoupdate](https://github.com/DomT4/homebrew-autoupdate)
```
$ brew tap domt4/autoupdate
```
2. Enable automatic updates once a day
```
$ brew autoupdate --start 86400 --upgrade --cleanup --enable-notification
```