# Contains functions to install and configure development environment. 

source "./dependencies.sh"

# Installs Git version control system and sets up user configurations. 
	# Sets up user name, email and end of line setting. 
	# Source: https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup
function install_setup_git() { 
	title "Installing & Configuring Git"
	
	echo "Configuring Git"
	git config --global user.name "Maruf Bepary"
	git config --global user.email "bepary71@gmail.com"
	git config --global core.autocrlf input
}

# Installs the recommended development packages. 
function install_developer_tools() { 
	title "Installing Developer Tools"
	
	sudo dnf -y groupinstall "Development Tools"
}

# Configures SSK key for GitHub.
	# Source: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
function configure_git_ssh() { 
	title "Configuring SSH Keys for GitHub"

	echo && echo && echo | ssh-keygen -t ed25519 -C "bepary71@gmail.com"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_ed25519
	cat ~/.ssh/id_ed25519.pub
}

# Installs Java Development Kit (JDK) for Java development. 
	# Source: https://docs.aws.amazon.com/corretto/latest/corretto-17-ug/generic-linux-install.html
function install_jdk() { 
	title "Instaling Java Development Environment"

	sudo rpm --import https://yum.corretto.aws/corretto.key 
 	sudo curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
	sudo yum install -y java-17-amazon-corretto-devel
}

# Installs Maven project manager for Java. 
function install_java_maven() {
	title "Installing Maven Project Manager for Java"

	package=("maven")
	install_native_apps "${package[@]}"
}

# Installs Pip package manager for Python. 
	# Source: https://www.osradar.com/install-pip-fedora-34/
function install_python_pip() {
	title "Installing Pip"

	package=("python3-pip")
	install_native_apps "${package[@]}"
}

# Installs Poetry Project Manager for Python. 
function install_python_poetry() {
	title "Installing Poetry Project Manager for Python"

	curl -sSL https://install.python-poetry.org | python3 -
	poetry config virtualenvs.prefer-active-python true
}

# Installs PyEnv for Python version management. 
	# Required Bash configuration added in custom `.bashrc` in this project
	# Source: https://github.com/pyenv/pyenv#automatic-installer
function install_pyenv() { 
	title "Installing PyEnv for Python"

	sudo dnf install -y git make gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel
	curl https://pyenv.run | bash
}

# Installs Visual Studio Code. 
	# Adds all the necessary keys and repositories. 
	# Source: https://www.linuxcapable.com/how-to-install-visual-studio-code-vs-code-on-fedora-34-35/
function install_vscode() { 
	# https://www.linuxcapable.com/how-to-install-visual-studio-code-vs-code-on-fedora-34-35/
	title "Installing Visual Studio Code"

	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
	sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
	
	package=("code")
	install_native_apps "${package[@]}"
}

# Installs Node.JS via Node Version Manager (NVM). 
	# This function is called by `install_node`. 
	# Source: https://heynode.com/tutorial/install-nodejs-locally-nvm/
function install_node_via_nvm() { 
	# https://heynode.com/tutorial/install-nodejs-locally-nvm/
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
	nvm install --lts
}

# Installs Node.JS and Yarn. 
function install_node() {
	title "Installing Node.JS, NPM and Yarn"

	install_node_via_nvm
	npm install --global yarn
}

# Installs Docker. 
	# Adds the necessary repository. 
	# Source: https://developer.fedoraproject.org/tools/docker/docker-installation.html
function install_docker() {
	title "Installing Docker"

	# Install Docker
	sudo dnf -y install dnf-plugins-core
	sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
	sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	sudo systemctl start docker

	# Non-Root config
	sudo dnf install -y fuse-overlayfs
	sudo dnf install -y iptables
	dockerd-rootless-setuptool.sh install

}

# Installs FlatHub apps required for development. 
function install_flathub_apps_development() { 
	title "Installing Development Flathub Apps"
	
	apps=(
		"io.beekeeperstudio.Studio"		# Beeker - Databases
		"rest.insomnia.Insomnia" 				# Insomnia - API Tool
		"org.gnome.gitg" 						# Git GUI
		"org.gnome.Boxes"						# Boxes - Virtual Machines
		)

	install_flathub_apps "${apps[@]}"
}

"$@"

