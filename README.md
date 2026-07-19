# Neovim Config

Uses **`vim.pack`** (Neovim 0.12 built-in plugin manager), based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

## Structure

```
init.lua                 # Entry point, PackChanged build hooks
lua/
  settings/
    options.lua          # vim.o / vim.opt settings
    keybinds.lua         # Core keymaps
  plugins/
    *.lua                # One file per plugin
```

## Plugins

| Plugin | File | Purpose |
|--------|------|---------|
| nvim-treesitter | `treesitter.lua` | Syntax highlighting, indentation |
| telescope.nvim | `telescope.lua` | Fuzzy finder (files, grep, LSP) |
| blink.cmp | `autocomplete.lua` | Autocompletion engine |
| LuaSnip | `autocomplete.lua` | Snippets |
| conform.nvim | `autoformat.lua` | Code formatting |
| nvim-lint | `lint.lua` | Linting (phpstan) |
| which-key.nvim | `whichkey.lua` | Keymap discovery |
| trouble.nvim | `trouble.lua` | Diagnostics list |
| gitsigns.nvim | `gitsigns.lua` | Git signs in gutter |
| neo-tree.nvim | `neotree.lua` | File tree |
| oil.nvim | `oil.lua` | File explorer (handles `nvim .`) |
| harpoon | `harpoon.lua` | Quick file navigation (`harpoon2`) |
| flash.nvim | `flash.lua` | Motion/jump tool |
| undotree | `undo.lua` | Undo history tree |
| vim-fugitive | `fugative.lua` | Git porcelain |
| vim-tmux-navigator | `vimtmuxnav.lua` | Tmux pane navigation |
| todo-comments.nvim | `todohighlights.lua` | Highlight TODO/FIXME comments |
| comment.nvim | `comment.lua` | Code commenting |
| mini.nvim | `mini.lua` | Icons, ai, surround, statusline |
| lualine.nvim | `lualine.lua` | Statusline |
| tokyonight.nvim | `colorscheme.lua` | Colorscheme |
| copilot.vim | `copilot.lua` | GitHub Copilot |
| supermaven-nvim | `copilot.lua` | AI completion (toggled) |
| fidget.nvim | `lsp.lua` | LSP status spinner |
| mason.nvim | `lsp.lua` | LSP/tool installer |

## System Dependencies

- **tree-sitter CLI** — compile nvim-treesitter parsers:
  - arch: `pacman -S tree-sitter-cli`
- **make** — build telescope-fzf-native and LuaSnip jsregexp:
  - arch: `pacman -S make`
- **Node.js** — required by copilot, intelephense, typescript-language-server:
  - arch: `pacman -S nodejs`

## Adding a New LSP

1. Add to the `servers` table in `lua/plugins/lsp.lua`:
   ```lua
   example_lsp = { capabilities = capabilities },
   ```
2. Add the Mason package name to `ensure_installed` in the same file:
   ```lua
   local ensure_installed = { ..., "example-lsp" }
   ```
3. Restart Neovim.

If Mason name differs from lspconfig name (e.g. `ts_ls` → `typescript-language-server`), use the Mason name in `ensure_installed`.

## Keymaps

### General

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `<Esc>` | `n` | Clear search highlight | `keybinds.lua` |
| `[d` / `]d` | `n` | Prev / Next diagnostic | `keybinds.lua` |
| `<leader>e` | `n` | Show diagnostic float | `keybinds.lua` |
| `<leader>q` | `n` | Location list | `keybinds.lua` |
| `<leader>d` | `n`, `v` | Delete to black hole | `keybinds.lua` |
| `x` | `n`, `v` | Delete char (no yank) | `keybinds.lua` |
| `<leader>p` | `n` | Horizontal split | `keybinds.lua` |
| `<leader>o` | `n` | Vertical split | `keybinds.lua` |
| `<Esc><Esc>` | `t` | Exit terminal mode | `keybinds.lua` |
| `<leader>lx` | `n` | Source current file | `keybinds.lua` |
| `<leader>ll` | `n`, `v` | Execute Lua line/selection | `keybinds.lua` |

### Telescope (Search)

| Key | Action | Source |
|-----|--------|--------|
| `<leader>sf` | Find files | `telescope.lua` |
| `<leader>saf` | Find files (include hidden) | `telescope.lua` |
| `<leader>sg` | Live grep | `telescope.lua` |
| `<leader>sag` | Live grep (include hidden) | `telescope.lua` |
| `<leader>sw` | Search current word | `telescope.lua` |
| `<leader>sh` | Search help | `telescope.lua` |
| `<leader>sk` | Search keymaps | `telescope.lua` |
| `<leader>ss` | Select Telescope picker | `telescope.lua` |
| `<leader>sd` | Search diagnostics | `telescope.lua` |
| `<leader>sr` | Resume last picker | `telescope.lua` |
| `<leader>s.` | Recent files | `telescope.lua` |
| `<leader>sn` | Neovim config files | `telescope.lua` |
| `<leader>st` | Colorscheme picker | `telescope.lua` |
| `<leader>s/` | Grep in open files | `telescope.lua` |
| `<leader>/` | Fuzzily search buffer | `telescope.lua` |
| `<leader><leader>` | Find buffers | `telescope.lua` |

### LSP

| Key | Action | Source |
|-----|--------|--------|
| `grd` | Go to definition | `telescope.lua` (LspAttach) |
| `grr` | Find references | `telescope.lua` (LspAttach) |
| `gri` | Go to implementation | `telescope.lua` (LspAttach) |
| `grt` | Go to type definition | `telescope.lua` (LspAttach) |
| `gO` | Document symbols | `telescope.lua` (LspAttach) |
| `gW` | Workspace symbols | `telescope.lua` (LspAttach) |
| `grn` | Rename symbol | `lsp.lua` (LspAttach) |
| `gra` | Code action | `lsp.lua` (LspAttach) |
| `grD` | Go to declaration | `lsp.lua` (LspAttach) |
| `<leader>ih` | Toggle inlay hints | `lsp.lua` (LspAttach) |

### Trouble (Diagnostics)

| Key | Action | Source |
|-----|--------|--------|
| `<leader>xx` | Toggle diagnostics | `trouble.lua` |
| `<leader>xX` | Buffer diagnostics | `trouble.lua` |
| `<leader>cs` | Symbols | `trouble.lua` |
| `<leader>cl` | LSP refs/defs | `trouble.lua` |
| `<leader>xL` | Location list | `trouble.lua` |
| `<leader>xQ` | Quickfix list | `trouble.lua` |

### Navigation

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `<leader>a` | `n` | Harpoon add file | `harpoon.lua` |
| `<leader>h` | `n` | Harpoon menu | `harpoon.lua` |
| `<leader>sp` | `n` | Harpoon picker (Telescope) | `harpoon.lua` |
| `g1`-`g7` | `n` | Harpoon jump 1-7 | `harpoon.lua` |
| `<tab>` | `n`, `x`, `o` | Flash jump | `flash.lua` |
| `<leader><tab>` | `n`, `x`, `o` | Flash treesitter | `flash.lua` |
| `-` | `n` | Open parent dir (Oil) | `oil.lua` |
| `<space>-` | `n` | Toggle Oil float | `oil.lua` |
| `<leader>t` | `n` | Toggle Neo-tree | `neotree.lua` |
| `<leader>u` | `n` | Toggle undotree | `undo.lua` |
| `<C-h/j/k/l>` | `n` | Tmux navigate | `vimtmuxnav.lua` |
| `<C-\>` | `n` | Tmux navigate previous | `vimtmuxnav.lua` |

### Formatting

| Key | Mode | Action | Source |
|-----|------|--------|--------|
| `<leader>f` | `n`, `v` | Format buffer | `autoformat.lua` |
