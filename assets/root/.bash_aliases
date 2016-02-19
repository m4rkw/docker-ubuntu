#!/bin/bash
export CLICOLOR="xterm-color"

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

if [ -e "$HOME/.hostname" ] ; then
	hostname=`cat $HOME/.hostname`
else
	hostname=`hostname`
fi

if [ -e "`which git`" ] ; then
	if [[ ${EUID} == 0 ]] ; then
		 PS1='\[\033[01;31m\]$hostname\[\033[01;34m\] \W\[\033[00m\]\[\033[01;31m\]$(parse_git_branch) \[\033[01;34m\]\$\[\033[00m\] '
	else
		 PS1='\[\033[01;32m\]$hostname\[\033[01;34m\] \w\[\033[00m\]\[\033[01;31m\]$(parse_git_branch) \[\033[01;34m\]\$\[\033[00m\] '
	fi
else
	if [[ ${EUID} == 0 ]] ; then
		PS1="\[\033[01;31m\]$hostname\[\033[01;34m\] \W\[\033[00m\] \[\033[01;34m\]\$\[\033[00m\] "
	else
		PS1="\[\033[01;32m\]$hostname\[\033[01;34m\] \w\[\033[00m\] \[\033[01;34m\]\$\[\033[00m\] "
	fi
fi

alias scpresume="rsync --partial --progress --rsh=ssh"

gitBranch() {
    git branch "$1"
    git checkout "$1"
}

alias s="ssh"
alias ga="git add"
alias gc="git commit"
alias gs="git status"
alias co="git checkout"
alias gb=gitBranch
alias i=". i"
alias console="php app/console"
alias f="cd /var/www/fleet"
alias ca="sudo ca"
alias pb="git branch --merged origin/develop | xargs git branch -d"
alias vs="~/code/vulnscan.rb"

if [ ! -e ~/.mysql_default_db ] ; then
	echo mysql > ~/.mysql_default_db
fi

set -o vi

if [[ ${EUID} == 0 ]] ; then
	alias con="netstat -pant |grep STAB"
else
	alias con="netstat -ant |grep STAB"
fi
if [[ ${EUID} == 0 ]] ; then
	alias listen="netstat -anp |egrep '^(tcp|udp)' |grep -v STAB |grep -v TIME_WAIT |grep -v CLOSE_WAIT |grep -v FIN_WAIT |grep -v LAST_ACK"
else
	alias listen="netstat -an |egrep '^(tcp|udp)' |grep -v STAB |grep -v TIME_WAIT |grep -v CLOSE_WAIT |grep -v FIN_WAIT |grep -v LAST_ACK"
fi
export PATH=$PATH:$HOME/bin:~/env/bin:/sbin:/usr/sbin
unset USERNAME
export LANG=en_GB.UTF-8
alias ls="ls --color"
export EDITOR=vi
