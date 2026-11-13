source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

if type -q tmux
    if not test -n "$TMUX"
        tmux attach-session -t hi; or tmux new-session -s hi
    end
end

if status is-interactive
    if not set -q SSH_AUTH_SOCK
        eval (ssh-agent -c) > /dev/null
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
        set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    end
end

