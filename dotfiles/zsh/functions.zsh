# t(): Opens a tmux 4-pane grid with optional commands per pane
#
# Usage:
#   t [dir] [pane0_cmd] [pane1_cmd] [pane2_cmd] [pane3_cmd]
#
# Defaults:
# - Pane 0: git pull
# - Pane 1: gh repo view
# - Pane 2: lazygit
# - Pane 3: aws-vault list

t() {
  local dir="$1"
  shift || true

  [ -z "$dir" ] && dir="$PWD"
  local name="${dir##*/}"

  # Accept optional custom commands
  local pane0="${1:-git pull}"
  local pane1="${2:-gh repo view}"
  local pane2="${3:-lazygit}"
  local pane3="${4:-aws-vault list}"

  tmux \
    new-window -n "$name" -c "$dir" \; \
    split-window -h -c "$dir" \; \
    split-window -v -c "$dir" \; \
    select-pane -t 0 \; split-window -v -c "$dir" \; \
    select-layout tiled \; \
    \
    select-pane -t 0 \; send-keys "$pane0" C-m \; \
    select-pane -t 1 \; send-keys "$pane1" C-m \; \
    select-pane -t 2 \; send-keys "$pane2" C-m \; \
    select-pane -t 3 \; send-keys "$pane3" C-m
}

asd() {
  t . \
    "btop" \
    "fastfetch" \
    "brew update ; brew outdated" \
    "cmatrix"
}
