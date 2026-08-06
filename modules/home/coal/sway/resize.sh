#!/bin/bash

# sway-resize <h|j|k|l> — push the focused window's shared edge in that direction.
# The shared edge always moves toward the pressed key: a window on the right of
# the split grows on h, a window on the left shrinks on h.

key=${1:?usage: sway-resize h|j|k|l}

read -r layout idx count < <(swaymsg -t get_tree | jq -r '
  . as $root
  | ([($root | .. | objects | select(.focused == true) | .id)] | .[0]) as $fid
  | $root
  | .. | objects
  | select(((.nodes // []) + (.floating_nodes // [])) | any(.id == $fid))
  | [.layout, ((.nodes | map(.id) | index($fid)) // -1), (.nodes | length)] | @tsv
')

fallback() {
  case "$key" in
    h) c="resize grow left" ;;
    l) c="resize grow right" ;;
    j) c="resize grow down" ;;
    k) c="resize grow up" ;;
  esac
}

case "$layout" in
  splith | splitv)
    if [ "$count" -lt 2 ]; then
      fallback
    else
      case "$key:$layout:$idx" in
        h:splith:0) c="resize shrink right" ;;
        h:splith:*) c="resize grow left" ;;
        l:splith:0) c="resize grow right" ;;
        l:splith:*) c="resize shrink left" ;;
        j:splitv:0) c="resize grow down" ;;
        j:splitv:*) c="resize shrink up" ;;
        k:splitv:0) c="resize shrink down" ;;
        k:splitv:*) c="resize grow up" ;;
      esac
    fi
    ;;
  *) fallback ;;
esac

swaymsg "$c 10px or 5ppt"
