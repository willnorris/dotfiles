#!/bin/sh

has "flatpak" || return

flatpak_bin="$XDG_DATA_HOME/flatpak/bin"
pathadd "${flatpak_bin}"

# flatpak_reshim builds CLI shims for all installed flatpak applications.
flatpak_reshim() {
  mkdir -p "$flatpak_bin"
  rm "$flatpak_bin"/*

  flatpak list --app --columns=application | awk "NR>0" |
    while read -r app; do
      cmd="/$(flatpak info -m "$app" | awk -F= '/^command=/ {print $2}')"
      [ -z "$cmd" ] && continue
      cat >"$flatpak_bin/$cmd" <<EOF
#/bin/sh

exec flatpak run $app "\$@"
EOF
      chmod +x "$flatpak_bin/$cmd"
    done
}
