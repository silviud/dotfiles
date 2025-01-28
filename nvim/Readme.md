# sd nvim


## Deps

- rust
- golang

### Formatters

Defined in `plugins/format.lua`, binaries are installed in `~/bin`

To see the log file in nvim `ConfirmInfo`


- `cargo install stylua`  or download from releases [StyLua](https://github.com/JohnnyMorganz/StyLua)
- [yamlfmt](https://github.com/google/yamlfmt/releases/download/v0.15.0/yamlfmt_0.15.0_Linux_x86_64.tar.gz)


### LSP

Lsp [configs](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md) - for each LSP to install. 

- lua_ls - download from [releases lua_ls](https://github.com/LuaLS/lua-language-server/releases/)
  extract archive in `~/bin/lua-language-server` and set path to `~/bin/lua-language-server/bin`
- yaml_ls - install node, npm - Note requires specific schemas for k8s
  install yarn globally `npm install -g yarn`
  yaml lsp `yarn global add yaml-language-server`
  This install will be under `~/.yarn/bin` - so needs to be added to $PATH


## Inspiration

https://github.com/Allaman/nvim/tree/main
