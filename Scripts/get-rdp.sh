#!/usr/bin/env bash

AUTH_DIR="$HOME/.config/rdp-auth"

# ---------- helpers ----------

show_error() {
  local title="$1" msg="$2"
  if command -v zenity >/dev/null; then
    zenity --error --title="$title" --no-markup --width=450 --text="$msg"
  elif command -v yad >/dev/null; then
    yad --image=dialog-error --title="$title" --text="$msg" --button=OK:0
  elif command -v notify-send >/dev/null; then
    notify-send -u critical "$title" "$msg"
  else
    printf '%s: %s\n' "$title" "$msg" >&2
  fi
}

get_value() {
  awk -F'=' -v key="$1" '
    $1 ~ "^[[:space:]]*" key "[[:space:]]*$" {
      sub(/^[[:space:]]+/, "", $2)
      sub(/[[:space:]]+$/, "", $2)
      print $2
      exit
    }
  ' "$file"
}

# ---------- sanity checks ----------

command -v xfreerdp3 >/dev/null || {
  show_error "RDP" "xfreerdp3 is not installed"
  exit 1
}
command -v bemenu >/dev/null || {
  show_error "RDP" "bemenu is not installed"
  exit 1
}
[[ -d "$AUTH_DIR" ]] || {
  show_error "RDP" "Profile directory not found:
$AUTH_DIR"
  exit 1
}

# ---------- profile picker ----------

selected=$(find "$AUTH_DIR" -maxdepth 1 -type f -printf '%f\n' | sort |
  bemenu -H 26 --cw 2 --ch 14 --hp 10 -i \
    -p "RDP Profile" --fn 'scientifica' \
    --tb="#7aa2f7" --tf="#1a1b26" \
    --fb="#1a1b26" \
    --nb="#1a1b26" --nf="#C5C8C6" \
    --ab="#1a1b26" --af="#C5C8C6" \
    --hb="#7aa2f7" --hf="#1a1b26")

[[ -z "$selected" ]] && exit 0

file="$AUTH_DIR/$selected"

# ---------- read profile ----------

ip=$(get_value ip)
username=$(get_value username)
domain=$(get_value domain)
password=$(get_value password)
drive=$(get_value drive-mount)

if [[ -z "$ip" ]]; then
  show_error "RDP: $selected" "No 'ip' set in profile file:
$file"
  exit 1
fi

# ---------- build command ----------

cmd=(
  xfreerdp3
  /f
  /dynamic-resolution
  /clipboard
  /auto-reconnect
  /cert:ignore

  # lighter on the server: no H.264 AVC444, LAN profile, less eye candy
  /network:lan
  /bpp:16
  /gfx:RFX
  -themes
  -wallpaper
  -aero
  -menu-anims
  -window-drag
)

cmd+=("/v:$ip")
[[ -n "$username" ]] && cmd+=("/u:$username")
[[ -n "$domain" ]] && cmd+=("/d:$domain")
[[ -n "$password" ]] && cmd+=("/p:$password")
[[ -n "$drive" ]] && cmd+=("/drive:Home,$drive")

# ---------- run + error handling ----------

log=$(mktemp /tmp/rdp-XXXXXX.log)
trap 'rm -f "$log"' EXIT

"${cmd[@]}" >"$log" 2>&1
rc=$?

# 0 = clean exit; 1/2/11 are usually normal disconnect/logoff/window closed.
# If you get popups on a normal close, add the exit code shown to this list.
case $rc in
0 | 1 | 2 | 11) exit 0 ;;
esac

err=$(grep -iE 'error|fail|denied|refused|timeout|logon|certificate' "$log" | tail -n 5)
[[ -z "$err" ]] && err=$(tail -n 5 "$log")

show_error "RDP: $selected" "Connection failed (exit code $rc)

${err:-No output from xfreerdp3}"
exit "$rc"
