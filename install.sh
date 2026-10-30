# Install: copies the layout and its mods into your Herdr app folder,
# checks every mod, and switches to the layout. Stops without copying
# anything if any square-nord file already exists.

(
  set -e
  home="${HERDR_APP_HOME:-$HOME/.config/herdr-app}"

  test ! -e "$home/layouts/square-nord.json"
  for mod in mods/square-nord-*; do
    test ! -e "$home/mods/${mod##*/}"
  done

  mkdir -p "$home/layouts" "$home/mods"
  cp layouts/square-nord.json "$home/layouts/"
  cp -R mods/square-nord-* "$home/mods/"

  for mod in "$home"/mods/square-nord-*; do
    herdr-app check "$mod"
  done

  herdr-app do layout.switch --name square-nord
)
