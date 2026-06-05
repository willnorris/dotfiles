export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

if [ -d "$CARGO_HOME/bin" ]; then
  pathadd "$CARGO_HOME/bin"
fi
