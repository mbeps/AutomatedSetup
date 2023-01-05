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

	sudo rpm --import https://yum.corretto.aws/corretto.key -y
	sudo curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
	sudo yum install -y java-17-amazon-corretto-devel
}

# Installs Maven project manager for Java. 
function install_java_maven() {
	title "Installing Maven Project Manager for Java"

	package=("maven")
	install_native_apps "${package[@]}"
}

# Installs PostgreSQL database. 
	# Database will not be accessible via third-party Database Management Systems (DBMS). 
	# On `/var/lib/pgsql/data/pg_hba.conf`, edit `host all all 127.0.0.1/32 ident` to `host all all 127.0.0.1/32 md5`
	# Source: https://docs.fedoraproject.org/en-US/quick-docs/postgresql/
function install_postgres() { 
	title "Installing PostgreSQL"

	package=("postgresql-server" "postgresql-contrib")
	install_native_apps "${package[@]}"

	sudo systemctl enable postgresql
	sudo postgresql-setup --initdb --unit postgresql
	sudo systemctl start postgresql
}

# Installs MySQL database
	# Source_ https://docs.fedoraproject.org/en-US/quick-docs/installing-mysql-mariadb/
function install_mysql() { 
	title "Installing MySQL"

	package=("community-mysql-server")
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

	package=("dnf-plugins-core")
	install_native_apps "${package[@]}"
	sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
	packages=(
		"docker-ce" 
		"docker-ce-cli"
		"containerd.io"
	)
	install_native_apps "${packages[@]}"
}

# Installs FlatHub apps required for development. 
function install_flathub_apps_development() { 
	title "Installing Development Flathub Apps"
	
	apps=(
		"io.dbeaver.DBeaverCommunity" 			# DBeaver - Database App
		"rest.insomnia.Insomnia" 				# Insomnia - API Tool
		"org.gnome.gitg" 						# Git GUI
		"org.gnome.Boxes"						# Boxes - Virtual Machines
		)

	install_flathub_apps "${apps[@]}"
}

"$@"

