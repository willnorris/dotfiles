#!/usr/bin/env bash

# open recently edited files in nvim
v() {
  nvim -c "Telescope oldfiles"
}
