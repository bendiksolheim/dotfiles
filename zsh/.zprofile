export LANG=no_NO.UTF-8

PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"

#Swift toochain
export SOURCEKIT_TOOLCHAIN_PATH="/Library/Developer/Toolchains/swift-latest.xctoolchain"

# Maven
export MAVEN_OPTS="-Xmx6g"
export M2_REPO=~/.m2/repository

# Npm
PATH=$PATH:~/.npm-package/bin

PATH=$PATH:~/.bin/

# Emacs
if [ -d "/Applications/Emacs.app/Contents/MacOS/bin" ]; then
    PATH="/Applications/Emacs.app/Contents/MacOS/bin:$PATH"
fi

if command -v "fnm" &>/dev/null; then
  eval "$(fnm env --shell=zsh)"
fi

source ~/.zprofile-custom
