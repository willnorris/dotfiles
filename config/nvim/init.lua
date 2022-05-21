vim.cmd "set runtimepath^=~/.vim runtimepath+=~/.vim/after"
vim.cmd "let &packpath = &runtimepath"
vim.cmd "source ~/.vim/vimrc"

require "user.options"
require "user.plugins"
require "user.keymaps"
require "user.color"
