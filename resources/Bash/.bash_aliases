alias editor="flatpak run org.gnome.TextEditor"
alias files="nautilus"
alias hardware-info="sudo lshw"
alias python3="/usr/bin/python3"
alias python="/usr/bin/python3"
alias pip3="/usr/bin/pip3"
# PostreSQL
alias postgres-stop="sudo systemctl stop postgresql"
alias postgres-start="sudo systemctl start postgresql"
# Docker
alias docker-stop="sudo systemctl stop docker"
alias docker-start="sudo systemctl start docker"
alias docker_desktop-stop="systemctl --user stop docker-desktop"
alias docker_desktop-start="systemctl --user enable docker-desktop"
# Mounting External Remote File Systems
alias mount-uni="sshfs zjac268@linux.cim.rhul.ac.uk:/home/cim/ug/zjac268 \"/home/maruf/Remotes/Royal Holloway Linux Server/\""
# Gnome Layouts
alias layout-windows="gnome-extensions disable dash-to-dock@micxgx.gmail.com && gnome-extensions disable Vitals@CoreCoding.com && gnome-extensions enable dash-to-panel@jderose9.github.com"
alias layout-personal="gnome-extensions enable dash-to-dock@micxgx.gmail.com && gnome-extensions enable Vitals@CoreCoding.com && gnome-extensions disable dash-to-panel@jderose9.github.com"
