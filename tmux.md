# TMUX Cheatsheet

## SECTION 1: COMMANDS

```bash
# Source tmux config file
tmux source-file ~/.tmux.conf

# Start a new tmux session
tmux new -s session_name

# List all tmux sessions
tmux ls

# Attach to an existing session
tmux attach -t session_name_or_number

# Kill a specific session
tmux kill-session -t session_name_or_number

# Rename current session
tmux rename-session -t old_name new_name

# Switch between sessions
tmux switch -t session_name

# Save current layout as a named layout
tmux list-windows > windows.txt

# Set a default terminal mode
tmux set-option -g default-terminal "screen-256color"

# Show help for all tmux commands
tmux list-commands

```

## SECTION 2: KEYMAPS

```bash
# Show all key bindings
Ctrl-b ?

# Detach from session
Ctrl-b d

# Split pane horizontally
Ctrl-b \"

# Split pane vertically
Ctrl-b %

# Toggle between panes
Ctrl-b o

# Switch to next window
Ctrl-b n

# Switch to previous window
Ctrl-b p

# Create new window
Ctrl-b c

# Rename window
Ctrl-b ,

# Close current pane
Ctrl-b x

# Move to pane in a direction
Ctrl-b Left / Right / Up / Down

# Resize pane
Ctrl-b Ctrl-Left / Ctrl-Right / Ctrl-Up / Ctrl-Down

# List sessions
Ctrl-b s

# Switch to a specific window by number
Ctrl-b 0 through Ctrl-b 9

# Kill current window
Ctrl-b &
```
