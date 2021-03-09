# installsd
makefile and shell wrapper to install and configuring most used command line software, tools and configuration zsh, oh-my-zsh, sdkman, brew etc

## Getting the repo
The below command will get the install script and then clone it locally to $HOME/code/src/github.com/installsd.git
```
curl -s https://raw.githubusercontent.com/crowz-fx/installsd/master/install.sh | /bin/bash
```

## Installing softwares and configuration
This will checkout, create symlinks zsh, fzf, vimfiles install softwares such as git-extras etc. See makefile.sh for full details
```
make all
```

## Optional setup of zsh and PATH configuration
This will create a new .zshrc and apped sdkman, $HOME/bin and $HOME/scripts to the PATH for easy access
```
make install_zsh_config
```
