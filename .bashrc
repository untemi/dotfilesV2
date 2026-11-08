[[ $- != *i* ]] && return
alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

export EDITOR=nvim

export CARGO_HOME="$HOME/.local/share/cargo"
export RUSTUP_HOME="$HOME/.local/share/rustup"
export NPM_CONFIG_CACHE="$HOME/.cache/npm"
export NUGET_PACKAGES="$HOME/.cache/nuget/packages"
export DOTNET_CLI_HOME="$HOME/.local/share/dotnet"

export GOPATH=$HOME/.go
export PATH="$CARGO_HOME/bin:$HOME/.local/bin:$GOPATH/bin:$PATH"
export WINEPREFIX=$HOME/Games/Wines/Staging

# export NO_AT_BRIDGE=1
export $(envsubst <$HOME/.sercrets)
