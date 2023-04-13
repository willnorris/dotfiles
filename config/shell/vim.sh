#!/bin/sh

# open recently edited files in nvim
v() {
  nvim -c "Telescope oldfiles"
}
