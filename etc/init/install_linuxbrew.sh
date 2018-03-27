
unset LD_LIBRARY_PATH
echo "unset LD_LIBRARY_PATH"
echo "installing Linuxbrew..."
which brew >/dev/null 2>&1 || sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
#試してないので不安しかない
test -d ~/.linuxbrew && PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
test -d /home/linuxbrew/.linuxbrew && PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
test -r ~/.bash_profile && echo 'export PATH="$(brew --prefix)/bin:$(brew --prefix)/sbin:$PATH"' >>~/.bash_profile
echo 'export PATH="$(brew --prefix)/bin:$(brew --prefix)/sbin:$PATH"' >>~/.profile
echo 'export PATH="$(brew --prefix)/bin:$(brew --prefix)/sbin:$PATH"' >>~/.zshrc.local

formulae=(
    gcc
    git
    zsh
    tmux
    ag
    # "vim --with-python3 --with-luajit" #kingでうまく入らなかった
    aria2
)

#echo "brew tap..."

echo "brew install apps..."
for formula in "${formulae[@]}"; do
    brew install $formula || brew upgrade $formula
done

brew cleanup

