# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

# Aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi



unset rc


export PS1='\[\e[0;1;91m\]\u\[\e[0;2;91m\]@\[\e[0;3;91m\]\h\[\e[0m\]:\[\e[0;2m\]/\[\e[0;38;5;39m\]\W\[\e[0;2m\]/\[\e[0;92m\]$(git branch 2>/dev/null | grep '"'"'^*'"'"' | colrm 1 2) \[\e[0m\]$ \[\e[0m\]'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# PyEnv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

