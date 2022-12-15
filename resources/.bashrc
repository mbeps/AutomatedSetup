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

unset rc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PS1='\[\e[0;1;91m\]\u\[\e[0;2;91m\]@\[\e[0;3;91m\]\h\[\e[0m\]:\[\e[0;2m\]/\[\e[0;38;5;39m\]\W\[\e[0;2m\]/\[\e[0;92m\]$(git branch 2>/dev/null | grep '"'"'^*'"'"' | colrm 1 2) \[\e[0m\]$ \[\e[0m\]'

# ALIASES
alias editor="flatpak run org.gnome.TextEditor"
alias files="nautilus"
alias hardware-info="sudo lshw"
alias python3="/usr/bin/python3"
alias python="/usr/bin/python3"
alias pip3="/usr/bin/pip3"
alias pyenv="$HOME/.pyenv"
# PostreSQL
alias postgres-stop="sudo systemctl stop postgresql"
alias postgres-start="sudo systemctl start postgresql"
# Docker
alias docker-stop="sudo systemctl stop docker"
alias docker-start="sudo systemctl start docker"
alias docker_desktop-stop="systemctl --user stop docker-desktop"
alias docker_desktop-start="systemctl --user enable docker-desktop"
# Conda
alias conda-stop="conda deactivate"
alias conda-start="conda activate"
alias git-sync="git pull && git push"
# Mounting External Remote File Systems
alias mount-uni="sshfs zjac268@linux.cim.rhul.ac.uk:/home/cim/ug/zjac268 \"/home/maruf/Remotes/Royal Holloway Linux Server/\""
# Gnome Layouts
alias layout-windows="gnome-extensions disable dash-to-dock@micxgx.gmail.com && gnome-extensions disable Vitals@CoreCoding.com && gnome-extensions enable dash-to-panel@jderose9.github.com"
alias layout-personal="gnome-extensions enable dash-to-dock@micxgx.gmail.com && gnome-extensions enable Vitals@CoreCoding.com && gnome-extensions disable dash-to-panel@jderose9.github.com"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/maruf/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/maruf/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/maruf/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/maruf/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
