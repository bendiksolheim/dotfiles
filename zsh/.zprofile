export LANG=no_NO.UTF-8

#Swift toochain
export SOURCEKIT_TOOLCHAIN_PATH="/Library/Developer/Toolchains/swift-latest.xctoolchain"

# Maven
export MAVEN_OPTS="-Xmx6g"
export M2_REPO=~/.m2/repository

# Npm
PATH=$PATH:~/.npm-package/bin

# jenv
PATH=$HOME/.jenv/bin:$PATH



eval "$(jenv init - --no-rehash)"
(jenv rehash &) 2> /dev/null

export PATH="$HOME/.cargo/bin:$PATH"
