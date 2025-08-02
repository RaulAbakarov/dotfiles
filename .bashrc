#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'


PS1='\[\e[01;31m\]┌──[\[\e[01;32m\]\u\[\e[01;34m\]@\h\[\e[01;31m\]]─[\[\e[01;36m\]\w\[\e[01;31m\]]
└─\[\e[01;32m\]\$\[\e[00m\] '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

fzf_nvim() {
  local file
  file=$(fzf --preview 'cat {}' --preview-window=right:60%)
  [[ -n "$file" ]] && nvim "$file"
}

bind -x '"\C-f": fzf_nvim'

export PATH="$HOME/bin:$PATH"


alias dotfiles='/usr/bin/git --git-dir=/home/lionn/.dotfiles/ --work-tree=/home/lionn'
alias dotfiles='/usr/bin/git --git-dir=/home/lionn/.dotfiles/ --work-tree=/home/lionn'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dotfiles='/usr/bin/git --git-dir=/home/lionn/.dotfiles/ --work-tree=/home/lionn'
alias dotfiles='/usr/bin/git --git-dir=/home/lionn/.dotfiles/ --work-tree=/home/lionn'
