# Neovim Config — Agent Guide

## Overview

This is a Neovim configuration using `vim.pack` (Neovim 0.12+ built-in plugin manager) with a kickstart.nvim-inspired approach. All plugins load at startup — no lazy-loading.

## Structure

```
init.lua              # Entry point: settings, PackChanged hooks, plugin module requires
lua/
  settings/
    options.lua       # vim.o / vim.opt settings only
    keybinds.lua      # General keymaps and autocmds
  plugins/
    *.lua             # One file per plugin: vim.pack.add() + setup()
```

## Conventions

- **One file per plugin** under `lua/plugins/`. File name matches plugin name.
- **No lazy-loading** — every plugin module is `require()`'d from `init.lua` at startup.
- **LSP config** uses `vim.lsp.config()` + `vim.lsp.enable()` (Neovim 0.12 API), not `lspconfig.SERVER.setup()`.
- **Mason** installs LSP binaries; `mason-tool-installer` handles `ensure_installed`.
- **Blink.cmp** provides autocompletion with `get_lsp_capabilities()`.
- **nvim-lint** uses `pcall` for linters with relative paths (e.g. `vendor/bin/phpstan`).

## Adding a Plugin

1. Create `lua/plugins/<name>.lua`
2. Add `vim.pack.add { "https://github.com/owner/repo" }`
3. Call `require("<name>").setup({...})` directly (no lazy loading)
4. Add `require("plugins.<name>")` to `init.lua` in the appropriate order

## Adding an LSP

1. Add entry to `servers` table in `lua/plugins/lsp.lua`:
   ```lua
   server_name = { capabilities = capabilities },
   ```
2. Add Mason package name to `ensure_installed` list (may differ from lspconfig name).
3. The `for` loop at the end of the file handles config + enable automatically.

## Version Constraints

Pin branches/tags when needed:
```lua
vim.pack.add { { src = gh "owner/repo", version = "branch-name" } }
-- or
vim.pack.add { { src = gh "L3MON4D3/LuaSnip", version = vim.version.range "2.*" } }
```

## Build Hooks

Defined in the `PackChanged` autocmd in `init.lua`. Runs after install/update for:
- `telescope-fzf-native.nvim` — `make`
- `LuaSnip` — `make install_jsregexp`
- `nvim-treesitter` — `TSUpdate`

## First-Run Safety

Colorscheme setup is wrapped in `vim.defer_fn` to avoid crashes when plugin modules aren't yet on the runtime path after initial install.

## LSP Keymap Pattern

LSP keymaps are set in two places:
- **Telescope-based** (grd, grr, gri, grt, gO, gW) — `telescope.lua` LspAttach autocmd
- **Native LSP** (grn, gra, grD) — `lsp.lua` LspAttach autocmd

## Formatting

Conform.nvim handles formatting via `<leader>f` or LSP fallback on save for opted-in filetypes.

## Linting

nvim-lint configured for PHP (phpstan). Errors from missing `vendor/bin/phpstan` are silently suppressed so non-Composer projects don't spam.
