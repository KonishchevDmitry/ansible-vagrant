#!/bin/sh
#
# Tunes Vagrant user's shell environment
#

# Steal SSH Agent if we don't have one (very useful when working with tmux)

ssh_agent_socket=~/.ssh/agent.socket

if [ -z "$SSH_AUTH_SOCK" ]; then
    export SSH_AUTH_SOCK="$ssh_agent_socket"
elif [ ! -L "$ssh_agent_socket" -o ! -e "$ssh_agent_socket" ]; then
    rm -f "$ssh_agent_socket" && ln -s "$SSH_AUTH_SOCK" "$ssh_agent_socket"
fi

unset ssh_agent_socket