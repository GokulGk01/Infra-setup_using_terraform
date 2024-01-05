#!/usr/bin/env bash
tmux new-session -d -s mysession

tmux send-keys -t mysession "cd /opt/composefiles && ./initrun.sh && ./dbinitsh" C-m

tmux detach -s mysession