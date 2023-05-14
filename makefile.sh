#!/usr/bin/env bash
set -e
set -x

GITHUB_DIR=$(echo $HOME)/code/src/github.com

function error_handler(){
    echo "Error occured, you might need to update, see above for more info"
    echo "Terminating..."
    exit 1
}

function install_zsh_config() {
    touch $HOME/.zshrc
    mkdir -p $HOME/bin
    mkdir -p $HOME/scripts
    echo "PATH BEFORE"
    echo $PATH
    echo "PATH=$PATH:$HOME/bin:$HOME/scripts" >> $HOME/.zshrc
    echo ""
    echo "PATH AFTER"
    echo $PATH
    echo "export SDKMAN_DIR='$HOME/.sdkman'" >> $HOME/.zshrc
    echo "[[ -s '$HOME/.sdkman/bin/sdkman-init.sh' ]] && source '$HOME/.sdkman/bin/sdkman-init.sh'" >> $HOME/.zshrc
}

function install_pip_list() {
    echo "Installing pip and modules..."
    easy_install --user pip || error_handler
    cd /tmp/ && curl -O https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py --user
	pip3 install awscli glances watchdog ansible virtualenv  --upgrade --user
    echo "Installed pip and modules!"
}

function install_aws_kubectl_aws_iam_authentication() {
    echo "Install kubectl and AWS auth..."
    INSTALL_DIR=build
    mkdir -p $INSTALL_DIR
    mkdir -p $HOME/bin
    curl -o $INSTALL_DIR/kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/darwin/amd64/kubectl
    curl -o $INSTALL_DIR/kubectl.sha256 https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/darwin/amd64/kubectl.sha256
    chmod +x $INSTALL_DIR/kubectl
    $INSTALL_DIR/kubectl version --short --client
    curl -o $INSTALL_DIR/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/darwin/amd64/aws-iam-authenticator
    curl -o $INSTALL_DIR/aws-iam-authenticator.sha256 https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/darwin/amd64/aws-iam-authenticator.sha256
    chmod +x $INSTALL_DIR/aws-iam-authenticator
    mv $INSTALL_DIR/kubectl $HOME/bin/
    mv $INSTALL_DIR/aws-iam-authenticator $HOME/bin/
    echo "Installed kubectl and AWS auth!"
}

function install_sdk_item() {
    source ~/.sdkman/bin/sdkman-init.sh && echo yes | sdk install $*
}

function install_sdkman_list(){
    echo "Installing sdkman and modules..."
    curl -s "https://get.sdkman.io" | bash
	
    SDK_INSTALL_ITEMS=( "groovy" "gradle" "grails" "java 8.0.282.fx-zulu" )
    # "infrastructor" "springboot" "maven" "gradleprofiler" "java 8.0.275-amzn" "java java 11.0.9-amzn", "11.0.10.fx-zulu"
    
    for item in "${SDK_INSTALL_ITEMS[@]}"
    do
        install_sdk_item $item
    done

    echo "Installed sdkman and modules!"
}

function install_brew_item() {
    brew install $* || error_handler
}

function install_brew_cask_item() {
    brew install cask $* || error_handler
}

function install_brew_list() {
    echo "Installing brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    echo "Installed brew!"

    echo "Updating brew..."
    brew update

    echo "Installing standard brew items..."
    BREW_INSTALL_ITEMS=( "colordiff" "fasd" "git" "git-extras" "git-flow" "htop-osx" "jq" "tmux" "tree" "wget" "zsh" "zsh-completions" "node" "ack" "fzf" \
        "python python3 pipenv" "watch" "yarn" "the_silver_searcher"  "warrensbox/tap/tfswitch" \
		"ctop" "git-secret" "helm@2" "awscli" "gnupg")
	# "grv" "cheat" "ctags" "httpie" "pwgen" "pstree" "packer" "blueutil" "Graphviz" "node@8" "unrar" "golang dep" "reattach-to-user-namespace" "kubectx" "subversion@1.8" 
	
    for item in "${BREW_INSTALL_ITEMS[@]}"
    do
        install_brew_item $item
    done
    echo "Installed standard brew items!"

    echo "Installing brew cask items..."
    BREW_CASK_INSTALL_ITEMS=( "spectacle" "iterm2" "aws-vault" )
    # "google-chrome", "dropbox", "sourcetree", "postman", "virtualbox", "vagrant", "vagrant-manager" "visual-studio-code"

    for item in "${BREW_CASK_INSTALL_ITEMS[@]}"
    do
        install_brew_cask_item $item
    done
    echo "Installed brew cask items!"
}

$*
