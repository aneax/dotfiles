#!/bin/bash

CROOT=$(pwd)
echo "Current path: $CROOT"

checkIt() {
	echo "Checking $2 ..."
	if [ -L "$2" ]; then
		echo "$1 already exists. Overwriting it."
		unlink $2
		#rm -rf $2
	fi
	ln -s $1 $2
}

DIR="$HOME/.config"
if [ ! -d "$DIR" ]; then
	echo "Directory not found: $DIR"
	mkdir "$DIR"
fi

echo "Installing config files in ${DIR}..."

echo "Installing tpm ..."
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

echo
echo "Configuring tmux"

# link the tmux
TMUXFILE="$CROOT/tmux/tmux.conf"
TMUXOUT="$HOME/.tmux.conf"
checkIt "$TMUXFILE" "$TMUXOUT"

echo "Install the plugins by using <prefix> I"
echo

# zshrc

echo "Configuring zsh(oh-my-zsh)"
ZSHFILE="$CROOT/zsh/zshrc"
ZSHOUT="$HOME/.zshrc"
checkIt "$ZSHFILE" "$ZSHOUT"

echo "Restart the terminal to apply the effects."
echo

echo "Configure neovim"
NVIM="$CROOT/nvim"
NOUT="$HOME/.config"
checkIt "$NVIM" "$NOUT"


echo "Configure gdb"
GDBFILE="$CROOT/gdb/gdbinit"
GDBOUT="$HOME/.gdbint"
checkIt "$GDBFILE" "$GDBOUT"

