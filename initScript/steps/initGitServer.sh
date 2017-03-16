#!/bin/bash
# create git user and ssh_keys
adduser git
sudo -u git -H bash -c "cd; mkdir -p .ssh && chmod 700 .ssh; touch .ssh/authorized_keys && chmod 600 .ssh/authorized_keys;"

# enable sshd user environment
sed -i -e 's/PermitUserEnvironment/#&/g' -e '/PermitUserEnvironment/a PermitUserEnvironment yes' /etc/ssh/sshd_config
sudo -u git -H bash -c "cd; echo PATH=$PATH >>.ssh/environment"
service sshd restart

# create bare project for 
mkdir -p /workBackup/project/git/twoplus_studio.git
chown -R git:git /workBackup/project/git
sudo -u git -H bash -c "source /etc/profile; cd /workBackup/project/git/twoplus_studio.git; git init --bare"
	
# restrict git user only can execute git shell
echo $(which git-shell) >>/etc/shells
chsh git -s $(which git-shell)

