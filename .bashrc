[[ $- != *i* ]] && return
alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

export $(envsubst < $HOME/.sercrets)

export EDITOR=nvim
export LIBVA_DRIVER_NAME=i965
export GSK_RENDERER=opengl

export GOPATH=$HOME/.go
export PATH=$HOME/.local/bin:$GOPATH/bin:$HOME/.cargo/bin:$PATH
export WINEPREFIX=$HOME/Games/Wines/Staging
