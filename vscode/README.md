# VS Code setup

## 1. Installation
1. [Download Visual Studio Code](https://code.visualstudio.com/Download) for your platform

2. Install it

## 2. Enable `code` command in shell (Mac):
```
$ ln -s /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code /usr/local/bin/code
```
- This creates a symbolic link – makes sure `/usr/local/bin/` is added to `$PATH`
- There are also [other ways of doing this](https://code.visualstudio.com/docs/setup/mac#_launching-from-the-command-line)

## 1. Restore settings
```
$ cp ~/setup/vscode/settings.json ~/Library/ApplicationSupport/Code/User/settings.json
```

## 2. Install extensions
```
$ cat ~/setup/vscode/vscode-extensions.txt | xargs -L 1 code --install-extension
```