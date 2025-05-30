# ─── Initialization ────────────────────────────────────────────────────────

source "$HOME/.local/share/zsh-plugins/zsh-defer.zsh"
eval "$(starship init zsh)"
zsh-defer eval "$(zoxide init zsh)"

# ─── Completion ────────────────────────────────────────────────────────────

zstyle ":completion:*" menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

autoload -Uz compinit
autoload edit-command-line; zle -N edit-command-line
autoload -Uz compinit 
_comp_options+=(globdots)

if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

compdef -d trash

# ─── Options ──────────────────────────────────────────────────────────────

setopt autocd interactive_comments
stty stop undef	
bindkey -e
unset VICMD

# ─── Plugins ──────────────────────────────────────────────────────────────

zsh-defer source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
zsh-defer source "/usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
zsh-defer source "/usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
zsh-defer source "$HOME/.local/share/zsh-plugins/doas-prefix.zsh"
zsh-defer source "$HOME/.local/share/zsh-plugins/dotenv.zsh"

# ─── History ──────────────────────────────────────────────────────────────

HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# ─── Aliases ──────────────────────────────────────────────────────────────

alias ls="exa --icons -A --group-directories-first"
alias ll="eza -Al --color=always --group-directories-first --git -h"
alias tree="eza --color=always --icons --tree"
alias grep="rg"
alias gtop="doas intel_gpu_top"
alias pmu="doas pacman -Syu"
alias c="clear"
alias myip="curl ip.me"
alias cd="z"
alias lspkg="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias clipdown="yt-dlp -S 'res:1080' -o ~/Videos/Clips/"
alias rm="trash"
alias apt-get="apt"
alias lf="lfub"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME'
alias neofetch="fastfetch -c neofetch.jsonc"
alias wsong="yt-dlp --audio-format mp3 -x"
alias goclean="\rm /tmp/go-build* -r"
alias pyenvrun="~/Development/Python/env/bin/python"
alias yapa="/usr/bin/ya"
alias imgup="~/.local/appimage/appimageupdatetool-x86_64.AppImage ~/.local/appimage/* -r"
alias x="chmod +x"
alias py="python"
alias pyenv="source .venv/bin/activate"
alias rswatch="cargo watch -x 'run -q'"
alias sudo="echo 'stop right there, use doas instead.\n'"

# ─── Functions ────────────────────────────────────────────────────────────

keyb() {
  xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

godoc() {
  curl curl -s cht.sh/go/{$1}
}

clean(){
  echo "\n\033[38;5;10m--- Flatpak CleanUp ---\033[0m"
  flatpak uninstall --unused --noninteractive
  flatpak uninstall --delete-data --noninteractive
  echo "\n\033[38;5;10m--- PacMan CleanUp ---\033[0m"
  yay -Sc --noconfirm
}

upall() {
  echo "\033[38;5;10m--- PacMan ---\033[0m"
  yay --noconfirm
  echo "\n\033[38;5;10m--- Flatpak Update ---\033[0m"
  flatpak update --noninteractive
  echo "\n\033[38;5;10m--- AppImage Update ---\033[0m"
  imgup
  echo "\n\033[38;5;10m--- Yazi plugins Update ---\033[0m"
  echo "..."
  yapa pack -u >/dev/null 2>&1
  echo "done"
  echo "\n\033[38;5;10m--- Nvchad Update ---\033[0m"
  echo "..."
  nvim --headless "+Lazy! sync" +qa >/dev/null 2>&1
  echo "\033[38;5;10m--- CleanUP ---\033[0m"
  clean
  echo "done"
}

apt() {
  echo "Bro we are not on Debian or Ubuntu or a shitty distro"
  sleep 3
  echo "Wait are you fucking DUMB ???"
  sleep 2
  echo "THIS IS ARCH YOU DUMBASS"
  sleep 1
  echo "ok Fuck off"
  sleep 2
  exit
}

function ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	\rm -f -- "$tmp"
}

function osc7-pwd() {
    emulate -L zsh # also sets localoptions for us
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}

function chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
}
add-zsh-hook -Uz chpwd chpwd-osc7-pwd

# ─── Keybinds ─────────────────────────────────────────────────────────────

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[d' doas-command-line
bindkey '^[e' edit-command-line 

bindkey '^H' backward-kill-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
