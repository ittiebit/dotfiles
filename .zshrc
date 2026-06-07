#
# ~/.zshrc
#

# Set default editor to nvim
export EDITOR=nvim
export PATH=~/.bin:~/.local/bin:~/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
#export XDG_DATA_DIRS=~/.bin:~/.local/bin:~/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:~/.local/share/flatpak/exports/share:/usr/local/share:/usr/share:/usr/bin


# Appearance

NEWLINE=$'\n'
#PS1=$'\n\n\n\n\n\n\e[6A'"$NEWLINE"$'\e[38;2;189;147;249m%1~ \e[0m\e[38;2;255;0;130m>> \e[0m'

autoload -U colors && colors
PS1="%{$(tput setaf 251)%}%1~ %{$(tput setaf 196)%}>> %{$(tput sgr0)%}"
#PS1="%{$(tput setaf 251)%}%1~ %{$(tput setaf 196)%}>> %{$(tput sgr0)%}"
#PS1=$'\n\n\n\n\n\n\e[6A'"$PS1"

#PS1="%{$(tput setaf 243)%}%n%{$(tput setaf 245)%}@%{$(tput setaf 249)%}%m %{$(tput setaf 254)%}%1~ %{$(tput setaf 220)%}$ %{$(tput sgr0)%}"
#export LS_COLORS='no=00;97:rs=00;97:fi=00;94:di=01;93:ln=00;37:pi=00;95:do=00;35:bd=00;94:cd=01;94:or=00;31:so=01;94:su=00;94:sg=00;94:tw=00;95:ow=00;95:st=01;95:ex=00;32:mi=00;31'
# https://github.com/mzawodnik/lscolors    useful for getting just the LS_COLORS out of a theme like 'monokai' or 'dracula'
export LS_COLORS="$(cat ~/.lscolors)"

## Enable colors for grep and ls
alias grep='grep --color=auto'
alias ls='ls --color=auto'


# History

HISTSIZE=100000 #should be bigger than savehist (https://unix.stackexchange.com/a/595475)
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt INC_APPEND_HISTORY # history file is updated immediately after a command is entered
setopt SHARE_HISTORY # allows multiple Zsh sessions to share the same command history 
setopt EXTENDED_HISTORY # records the time when each command was executed along with the command itself
setopt APPENDHISTORY # ensures that each command entered in the current session is appended to the history file immediately after execution
export HISTTIMEFORMAT="%d/%m/%Y %H:%M] "


# Make command editing and other inputs behave like bash (https://stackoverflow.com/questions/12382499/looking-for-altleftarrowkey-solution-in-zsh)

#setopt autocd nomatch
bindkey -e
bindkey "^[[3~" delete-char                     # Key Del
bindkey "^[[5~" beginning-of-buffer-or-history  # Key Page Up
bindkey "^[[6~" end-of-buffer-or-history        # Key Page Down
bindkey "^[[H" beginning-of-line                # Key Home
bindkey "^[[F" end-of-line                      # Key End
bindkey "^[[1;3C" forward-word                  # Key Alt + Right
bindkey "^[[1;3D" backward-word                 # Key Alt + Left
bindkey "^[[1;5C" forward-word                  # Key Ctrl + Right
bindkey "^[[1;5D" backward-word                 # Key Ctrl + Left


# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall


# Tmux

## Auto-attach tmux on opening terminal
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach-session -t 0 || tmux new-session -s 0
fi

list_tmux() {
    session=""
    if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
        tmux ls -F \#{session_name} | fzf | while read fzf_selection; do 
            session = fzf_selection;
        done
    fi
    tmux attach-session -t "$session"
}

run_tmux() {
    if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
      tmux attach-session
    fi
}
zle -N run_tmux
bindkey -s '^f' run_tmux
alias 'f'=run_tmux


# Set up fzf key bindings and fuzzy completion

source <(fzf --zsh)
## Alternative: basic Ctrl+r reverse search
#bindkey '^R' history-incremental-search-backward


# Nvim

run_nvim() {
    nvim .
}
zle -N run_nvim
bindkey '^k' run_nvim

bindkey -s '^h' 'tmux-sessionizer\n'


# Open anything with xdg-open

alias 'open'='xdg-open'
alias 'o'='xdg-open'

conda_setup() {
    __conda_setup="$('$HOME/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
            . "$HOME/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="$HOME/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup;

    conda deactivate;

    export CONDA_SETUP=1

    echo "Setting up conda..."
}

conda_trigger() {
    if [ "$CONDA_SETUP" -ne "1" ]; then
        conda_setup;
    fi

    if [ -z "$CONDA_DEFAULT_ENV" ]; then
        echo "Activating conda..."
        conda activate;
    else
        echo "Deactivating conda..."
        conda deactivate;
    fi
}
zle -N conda_trigger
bindkey -s '^n' conda_trigger

eval "$(ssh-agent -s)" > /dev/null
