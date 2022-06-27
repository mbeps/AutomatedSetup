# Displays title for functions. 
	# Args:
		# - $1: title to be printed. 
function title() {
    echo 
	echo $1
}

# List all the installed Flatpak apps. 
function flatpakInstalledApps() {
    title "Installed Flatpak Apps"

    flatpak list --app
}

# List all the installed packages. 
function nativeInstalledPackages() {
    title "Installed Native Packages"

    dnf list --installed
}

# Displays DNF configurations. 
function checkDNFConfig() {
    title "Checks DNF Configuration"

    cat /etc/dnf/dnf.conf
}

# Checks whether Java Development Kit is installed by checking versions. 
function checkJava() {
    title "Checks Java Version"

    java --version
    javac --version
}

# Checks whether Python and Pip is installed by checking versions. 
function checksPython() {
    title "Checks Python Version"

    python3 --version
    pip3 --version
    poetry --version
}

# Checks whether Git is installed by checking version and checks user configurations. 
function checkGit() {
    title "Checks Git Version & Configurations"

    git --version
    git config --get user.name
    git config --get user.email
}

# Checks whether SSH keys are present. 
function checkGithubSSH() {
    title "Checks Github SSH Keys"

    ls -al ~/.ssh
}

# Checks whether PostgreSQL is installed by checking version. 
function checkPostgres() {
    title "Checks PostgreSQL Version"

    psql --version
}

# Checks whther Visual Studio Code is installed by checking version. 
function checkVSCode() {
    title "Checks Visual Studio Code Version"

    code --version
}

# Checks whether Node.JS, NVM and Yarn are installed by checking version. 
function checkNode() {
    title "Checks Node.JS, NVM and Yarn"

    nvm --version
    node --version
    yarn --version
}

flatpakInstalledApps
nativeInstalledPackages
checkDNFConfig
checkJava
checksPython
checkGit
checkGithubSSH
checkPostgres
checkNode
checkVSCode

"$@"