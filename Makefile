all:  install_tools
install_tools: install_brew_list install_pip_list install_sdkman_all install_aws_kubectl_aws_iam_authentication 

clean:
	rm -rf build

install_zsh_config:
	./makefile.sh install_zsh_config

install_brew_list:
	./makefile.sh install_brew_list

install_pip_list:
	./makefile.sh install_pip_list

install_sdkman_all:
	./makefile.sh install_sdkman_list

install_aws_kubectl_aws_iam_authentication:
	./makefile.sh install_aws_kubectl_aws_iam_authentication