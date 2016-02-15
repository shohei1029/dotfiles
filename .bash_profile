alias la='ls -la'
alias laf='ls -laF'
alias af='ls -aF'
alias showx='defaults write com.apple.finder AppleShowAllFiles -boolean true'
alias hidex='defaults delete com.apple.finder AppleShowAllFiles'

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

source .bashrc

#autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT=/Users/NagataShohei/cocos2d-x/tools/cocos2d-console/bin
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable NDK_ROOT for cocos2d-x
export NDK_ROOT=/Users/NagataShohei/android-ndk
export PATH=$NDK_ROOT:$PATH

# Add environment variable ANDROID_SDK_ROOT for cocos2d-x
export ANDROID_SDK_ROOT=/Applications/Android SDK
export PATH=$ANDROID_SDK_ROOT:$PATH
export PATH=$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH

# Add environment variable ANT_ROOT for cocos2d-x
export ANT_ROOT=/usr/local/bin
export PATH=$ANT_ROOT:$PATH

[ -s "/Users/NagataShohei/.nvm/nvm.sh" ] && . "/Users/NagataShohei/.nvm/nvm.sh" # This loads nvm


#julia
export PATH=$PATH:/Applications/Julia-0.3.0.app/Contents/Resources/julia/bin

# ruby
export PATH="$HOME/.rbenv/bin:$PATH"
# ~env
eval "$(rbenv init -)"
eval "$(pyenv init -)"
eval "$(plenv init -)"

