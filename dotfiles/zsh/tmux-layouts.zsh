#   t(): Opens a tmux 4-pane grid with some defaults programs
#
#   +---------+---------+
#   | Pane 0  | Pane 1  |
#   +---------+---------+
#   | Pane 2  | Pane 3  |
#   +---------+---------+
#
# - Pane 0: git pull
# - Pane 1: gh repo view
# - Pane 2: lazygit
# - Pane 4: aws-vault list

t() {
  local dir="$1"
  [ -z "$dir" ] && dir="$PWD"

  local name="${dir##*/}"  # Extract basename

  tmux \
    new-window -n "$name" -c "$dir" \; \
    split-window -h -c "$dir" \; \
    split-window -v -c "$dir" \; \
    select-pane -t 0 \; split-window -v -c "$dir" \; \
    select-layout tiled \; \
    \
    select-pane -t 0 \; send-keys "git pull" C-m \; \
    select-pane -t 1 \; send-keys "gh repo view" C-m \; \
    select-pane -t 2 \; send-keys "lazygit" C-m \; \
    select-pane -t 3 \; send-keys "aws-vault list" C-m
}