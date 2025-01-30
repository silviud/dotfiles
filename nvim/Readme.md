# sd nvim

## Deps

- golang

### Formatters

Defined in `plugins/format.lua`, binaries are installed in `~/bin`

To see the log file in nvim `ConfirmInfo`

- lua `cargo install stylua` or download from releases [StyLua](https://github.com/JohnnyMorganz/StyLua)
- yaml - [yamlfmt](https://github.com/google/yamlfmt/releases/download/v0.15.0/yamlfmt_0.15.0_Linux_x86_64.tar.gz)
- html, javascript - `npm install -g prettier`
- markdown - `npm install markdownlint-cli2 --global`
- python - [ruff](https://github.com/astral-sh/ruff/releases) - shell script or download and install.

### LSP

Lsp [configs](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md) - for each LSP to install.

- lua_ls - download from [releases lua_ls](https://github.com/LuaLS/lua-language-server/releases/)
  extract archive in `~/bin/lua-language-server` and set path to `~/bin/lua-language-server/bin`
- yaml_ls - install node, npm - Note requires specific schemas for k8s
  install globally `npm install -g yaml-language-server`
  This install will be under `$HOME/.nvm/versions/node/vX.X.X/bin` - so needs to be added to $PATH
  if using nvm or in the default `npm` location (sudo to install).
- markdown - [markdown](https://github.com/artempyanykh/marksman/releases) download and install
- html - `npm i -g vscode-langservers-extracted`
- htmx - `cargo install htmx-lsp` (experimental)
- python - `pip install -U jedi-language-server`
- jinja2 - [jinja-lsp](https://github.com/uros-5/jinja-lsp/releases)
  fails `./jinja-lsp-linux-x64: /lib/x86_64-linux-gnu/libc.so.6: version GLIBC_2.32' not found (required by ./jinja-lsp-linux-x64)`
  need cargo install to build with rust

## Inspiration

<https://github.com/Allaman/nvim/tree/main>
