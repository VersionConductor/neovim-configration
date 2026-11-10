# Neovim Configuration Documentation

**Version:** 1.0.0  
**Editor:** Neovim 0.11+  
**Language:** Lua  
**Plugin Manager:** Lazy.nvim  
**Configuration Style:** Modular

---

### Documentation
- [Neovim Lua Guide](https://neovim.io/doc/user/lua-guide.html)

### Table of Contents
- [Requirements & Installation](#requirements--installation)
  - [Required Tools](#required-tools)
  - [Windows Installation](#windows-installation)
  - [Lazy.nvim](#lazynvim)
  - [Keybindings](#keybindings)
  - [Remap shortcuts](#remap-shortcuts)
- [Plugin Configurations](#plugin-configurations)
  - [Treesitter](#treesitter)
  - [Telescope](#telescope)
  - [Telescope shortcuts](#telescope-shortcuts)
  - [Harpoon 2](#harpoon-2)
  - [Harpoon shortcuts](#harpoon-shortcuts)
  - [Vim Fugitive](#vim-fugitive)
  - [Fugitive shortcuts](#fugitive-shortcuts)
  - [LSP Configuration](#lsp-configuration)
  - [Required plugins](#required-plugins)
  - [Recommended language servers](#recommended-language-servers)
  - [Useful commands](#useful-commands)
- [Completion System](#completion-system)
  - [Dependencies](#dependencies)
  - [LSP Keybindings](#lsp-keybindings)
- [Complete Keybinding Reference](#complete-keybinding-reference)
  - [General](#general)
  - [File navigation](#file-navigation)
  - [Git](#git)
  - [Search](#search)
  - [Navigation](#navigation)
  - [Editing](#editing)
  - [Folding](#folding)
  - [AI and snippets](#ai-and-snippets)
  - [Other plugins](#other-plugins)
- [Installation and Maintenance](#installation-and-maintenance)
  - [Install plugins](#install-plugins)
  - [Update plugins](#update-plugins)
  - [Remove unused plugins](#remove-unused-plugins)
  - [Open plugin manager](#open-plugin-manager)
  - [Update Tree-sitter parsers](#update-tree-sitter-parsers)
  - [Install language servers](#install-language-servers)
  - [Check configuration health](#check-configuration-health)
- [Troubleshooting](#troubleshooting)
- [Git Versioning](#git-versioning)
  - [Future versions](#future-versions)
- [Official Documentation Index](#official-documentation-index)
---

# Requirements & Installation

### Required tools

| Package | Purpose |
|---|---|
| [Neovim](https://neovim.io/) | Text editor |
| [Git](https://git-scm.com/) | Version control and plugin installation |
| [Node.js](https://nodejs.org/) | JavaScript language servers |
| [Make](https://www.gnu.org/software/make/) | Building native dependencies |
| [Ripgrep](https://github.com/BurntSushi/ripgrep) | Fast text searching |
| [fd](https://github.com/sharkdp/fd) | Fast file searching |
| C compiler | Tree-sitter parser compilation |
| luarocks | To build Plenary |

### Windows installation

```powershell
winget install Neovim.Neovim
winget install Git.Git
winget install OpenJS.NodeJS.LTS
```

Verify:

```bash
nvim --version
git --version
node --version
npm --version
```

---

# Directory Structure

```text
nvim/
├── init.lua
└── lua/
    └── custom/
        ├── init.lua
        ├── set.lua
        ├── remap.lua
        │
        └── lazy/
            ├── colorscheme.lua
            ├── treesitter.lua
            ├── lsp.lua
            ├── completion.lua
            ├── luasnip.lua
            ├── supermaven.lua
            ├── trouble.lua
            ├── neotree.lua
            ├── telescope.lua
            ├── harpoon.lua
            ├── fugitive.lua
            ├── lualine.lua
            ├── indent-blankline.lua
            └── neogen.lua
            └── ...
```

---

# Main Configuration

### `init.lua`

```lua
require("custom.lazy")
require("custom.remap")
require("custom.init_lazy")
```

### Lazy.nvim

Documentation: [Lazy.nvim](https://lazy.folke.io/)

File: `lua/custom/lazy.lua`

```lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })

    if vim.v.shell_error ~= 0 then
        error("Failed to install Lazy.nvim")
    end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("custom.lazy", {
    change_detection = {
        notify = false,
    },
})
```

---

# Keybindings

Documentation: [Neovim Lua Keymaps](https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings)

File: `lua/custom/keymaps.lua`

```lua
vim.g.mapleader = " "

local map = vim.keymap.set

-- Move lines
map("v", "<leader>k", ":move '<-2<CR>gv=gv", {
    desc = "Move Selection Up",
})
map("v", "<leader>j", ":move '>+<CR>gv=gv", {
    desc = "Move Selection Down",
})

-- Quickfix
map("n", "<C-k>", "<cmd>cnext<CR>zz", {
    desc = "Next Quickfix",
})
map("n", "<C-j>", "<cmd>cprev<CR>zz", {
    desc = "Previous Quickfix",
})

-- Location List
map("n", "[l", "<cmd>lnext<CR>zz", {
    desc = "Next Location Item",
})
map("n", "]l", "<cmd>lprev<CR>zz", {
    desc = "Previous Location Item",
})

-- Tmux
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", {
    desc = "Tmux Sessionizer",
})

```

### Remap shortcuts

| Shortcut | Action |
|---|---|
| `mapleader` | "space" leader |
| `<leader>pv` | Open Explorer |
| `<leader><leader>` | Reload Current File |
| `<leader>z` | Toggle Fold |
| `<leader>o` | Open Fold |
| `<leader>c` | Close Fold |
| `<leader>e` | Toggle Explorer |
| `<leader>k` | Move Line Up |
| `<leader>j` | Move Line Down |
| `<leader>p` | Paste Without Overwriting |
| `<leader>y` | Yank to Clipboard |
| `<leader>Y` | Yank Line to Clipboard |
| `<leader>d` | Delete Without Yanking |
| `<leader>s` | Replace Word Under Cursor |
| `<leader>x` | Make File Executable |
| `<leader>f` | Format Document |
| `<leader>th` | Select Colorscheme |

---

# Plugin Configurations

All files below belong in `lua/custom/lazy/`.

## Treesitter

Repository: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

Provides syntax highlighting, indentation, and syntax-aware folding.

```lua
return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "html",
                "javascript",
                "typescript",
                "tsx",
                "php",
                "bash",
                "json",
            },

            sync_install = false,
            auto_install = true,

            highlight = {
                enable = true,
            },

            indent = {
                enable = true,
            },
        })
    end,
}
```

**Note:** This uses the legacy `master` branch API. The newer `main` branch has a different configuration API and requires Neovim 0.12+.

## Telescope

Repository: [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

A fuzzy finder for files, buffers, Git files, and text searching.

```lua
return {
    ...

    keys = {
        {
            "<leader>pf",
            "<cmd>Telescope find_files<CR>",
            desc = "Find Files",
        },
        {
            "<C-p>",
            "<cmd>Telescope git_files<CR>",
            desc = "Find Git Files",
        },
        {
            "<C-b>",
            "<cmd>Telescope buffers<CR>",
            desc = "Find Buffers",
        },
        {
            "<leader>lg",
            "<cmd>Telescope live_grep<CR>",
            desc = "Live Grep",
        },
        {
            "<leader>vh",
            "<cmd>Telescope help_tags<CR>",
            desc = "Help Tags",
        },
    },
}
```

### Telescope shortcuts

| Shortcut | Action |
|---|---|
| `<leader>pf` | Find files |
| `<C-p>` | Search Git files |
| `<C-b>` | List open buffers |
| `<leader>lg` | Search text throughout project |
| `<leader>vh` | Search Neovim help |

**Dependencies and commands:**

```bash
git
make
rg
fd
```

## Harpoon 2

Harpoon allows you to bookmark important files and navigate between them quickly.

Your configuration uses the `harpoon2` branch.

```lua
return {
    
    ...

    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        local map = vim.keymap.set

        ...

        -- Add files
        map("n", "<leader>A", function()
            harpoon:list():prepend()
        end, { desc = "Prepend Harpoon File" })

        map("n", "<leader>a", function()
            harpoon:list():add()
        end, { desc = "Add Harpoon File" })

       ...
    end,
}
```

### Harpoon shortcuts

| Shortcut | Action |
|---|---|
| `<leader>A` | Prepend current file |
| `<leader>a` | Add current file |
| `<C-e>` | Open Harpoon menu |
| `<C-h>` | Open file 1 |
| `<C-t>` | Open file 2 |
| `<C-n>` | Open file 3 |
| `<C-s>` | Open file 4 |
| `<leader><C-h>` | Replace slot 1 |
| `<leader><C-t>` | Replace slot 2 |
| `<leader><C-n>` | Replace slot 3 |
| `<leader><C-s>` | Replace slot 4 |
| `<C-S-P>` | Previous item |
| `<C-S-N>` | Next item |

## Vim Fugitive

Repository: [vim-fugitive](https://github.com/tpope/vim-fugitive)

A Git wrapper that integrates Git commands directly into Neovim.

```lua
return {
    ...

    keys = {
        {
            "<leader>gs",
            "<cmd>Git<CR>",
            desc = "Git Status",
        },
    },
}
```

### Fugitive shortcuts

| Shortcut | Action |
|---|---|
| `<leader>gs` | Open Git status |

### Useful Fugitive commands

```vim
:Git
:Git status
:Git add %
:Git commit
:Git push
:Git pull
:Git log
:Git diff
```

Inside the Fugitive status window, you can stage, unstage, and commit files interactively.

# LSP Configuration

Documentation:

- [Neovim LSP](https://neovim.io/doc/user/lsp.html)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [Mason.nvim](https://github.com/mason-org/mason.nvim)
- [Mason LSP Config](https://github.com/mason-org/mason-lspconfig.nvim)

### Required plugins

```lua
{
    "neovim/nvim-lspconfig",
}

{
    "mason-org/mason.nvim",
    opts = {},
}

{
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        "mason-org/mason.nvim",
        "neovim/nvim-lspconfig",
    },
}
```

### Recommended language servers

| Language | Server |
|---|---|
| Lua | `lua_ls` |
| JavaScript | `ts_ls` |
| TypeScript | `ts_ls` |
| PHP | `intelephense` |
| Python | `pyright` |
| Go | `gopls` |
| HTML | `html` |
| CSS | `cssls` |
| JSON | `jsonls` |
| Tailwind CSS | `tailwindcss` |
| ESLint | `eslint` |
| Emmet | `emmet_language_server` |

For Neovim 0.11+, use:

```lua
vim.lsp.config()
vim.lsp.enable()
```

### Useful commands

```vim
:Mason
:LspInfo
:checkhealth vim.lsp
```

---

# Completion System

Documentation:

- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
- [cmp-path](https://github.com/hrsh7th/cmp-path)
- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)

### Dependencies

```lua
{
    "hrsh7th/nvim-cmp",
}

{
    "hrsh7th/cmp-nvim-lsp",
}

{
    "hrsh7th/cmp-buffer",
}

{
    "hrsh7th/cmp-path",
}

{
    "saadparwaiz1/cmp_luasnip",
}
```

Recommended completion sources:

```lua
sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer" },
}
```

---

# LSP Keybindings

Documentation: [Neovim LSP API](https://neovim.io/doc/user/lsp.html)

Recommended buffer-specific shortcuts:

| Shortcut | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<leader>vca` | Code actions |
| `<leader>vrn` | Rename symbol |
| `<leader>vd` | Show diagnostics |
| `<leader>vws` | Workspace symbols |
| `<leader>f` | Format document |

Register these through an `LspAttach` autocmd.

---

# Complete Keybinding Reference

All mappings use Space as the leader key.

### General

| Shortcut | Action |
|---|---|
| `<leader>pv` | Open Explorer |
| `<leader><leader>` | Reload current file |
| `Q` | Disabled |
| `<C-c>` | Escape insert mode |

### File navigation

| Shortcut | Action |
|---|---|
| `<leader>e` | Neo-tree |
| `<leader>pf` | Telescope find files |
| `<C-p>` | Telescope Git files |
| `<C-b>` | Telescope buffers |
| `<C-e>` | Harpoon menu |
| `<C-h>` | Harpoon file 1 |
| `<C-t>` | Harpoon file 2 |
| `<C-n>` | Harpoon file 3 |
| `<C-s>` | Harpoon file 4 |
| `<leader>a` | Add Harpoon file |
| `<leader>A` | Prepend Harpoon file |

### Git

| Shortcut | Action |
|---|---|
| `<leader>gs` | Fugitive Git status |
| `<C-p>` | Telescope Git files |

### Search

| Shortcut | Action |
|---|---|
| `<leader>lg` | Live grep |
| `<leader>vh` | Help tags |
| `<leader>s` | Replace word under cursor |

### Navigation

| Shortcut | Action |
|---|---|
| `<leader>k` | Move line up |
| `<leader>j` | Move line down |
| `<C-k>` | Next quickfix item |
| `<C-j>` | Previous quickfix item |
| `[l` | Next location item |
| `]l` | Previous location item |
| `[t` | Previous Trouble item |
| `]t` | Next Trouble item |
| `<C-S-P>` | Previous Harpoon item |
| `<C-S-N>` | Next Harpoon item |

### Editing

| Shortcut | Action |
|---|---|
| `<leader>p` | Paste without overwriting |
| `<leader>y` | Yank to system clipboard |
| `<leader>Y` | Yank line to system clipboard |
| `<leader>d` | Delete without yanking |
| `<leader>x` | Make executable |
| `<leader>f` | Format document |

### Folding

| Shortcut | Action |
|---|---|
| `<leader>z` | Toggle fold |
| `<leader>o` | Open fold |
| `<leader>c` | Close fold |

### AI and snippets

| Shortcut | Action |
|---|---|
| `<Tab>` | Accept Supermaven suggestion |
| `<C-]>` | Clear suggestion |
| `<C-j>` | Accept suggestion word |
| `<C-s>e` | Expand LuaSnip |
| `<C-s>;` | Next snippet placeholder |
| `<C-s>,` | Previous snippet placeholder |
| `<C-E>` | Change snippet choice |

### Other plugins

| Shortcut | Action |
|---|---|
| `<leader>tt` | Trouble diagnostics |
| `<leader>th` | Theme selector |
| `<leader>mr` | Cellular Automaton |
| `<leader>nf` | Neogen function documentation |
| `<leader>nc` | Neogen class documentation |
| `<leader>nt` | Neogen type documentation |
| `<leader>na` | Neogen file documentation |
| `<C-f>` | Tmux sessionizer |

---

# Installation and Maintenance

### Install plugins

```vim
:Lazy sync
```

### Update plugins

```vim
:Lazy update
```

### Remove unused plugins

```vim
:Lazy clean
```

### Open plugin manager

```vim
:Lazy
```

### Update Tree-sitter parsers

```vim
:TSUpdate
```

### Install language servers

```vim
:Mason
```

### Check configuration health

```vim
:checkhealth
```

---

# Troubleshooting

| Problem | Solution |
|---|---|
| Plugins not loading | `:Lazy sync` |
| LSP not working | `:LspInfo` |
| Missing language server | `:Mason` |
| Tree-sitter errors | `:TSUpdate` |
| Telescope search unavailable | Install Ripgrep |
| FZF native build failure | Check Make and C compiler |
| Harpoon not working | Check `harpoon2` branch |
| Fugitive not working | Check Git installation |
| Snippets not expanding | Check LuaSnip loading |
| Supermaven not suggesting | `:SupermavenStatus` |
| Missing icons | Install `nvim-web-devicons` |

---

# Git Versioning

### Future versions

| Version | Purpose |
|---|---|
| `v1.0.0` | First stable release |
| `v1.0.1` | Bug fixes |
| `v1.1.0` | New features |
| `v2.0.0` | Breaking changes |

---

# Official Documentation Index

| Technology | Documentation |
|---|---|
| Neovim | [Official Docs](https://neovim.io/doc/) |
| Lazy.nvim | [Documentation](https://lazy.folke.io/) |
| Telescope | [GitHub](https://github.com/nvim-telescope/telescope.nvim) |
| Telescope FZF | [GitHub](https://github.com/nvim-telescope/telescope-fzf-native.nvim) |
| Harpoon | [GitHub](https://github.com/ThePrimeagen/harpoon) |
| Fugitive | [GitHub](https://github.com/tpope/vim-fugitive) |
| Neo-tree | [GitHub](https://github.com/nvim-neo-tree/neo-tree.nvim) |
| Treesitter | [GitHub](https://github.com/nvim-treesitter/nvim-treesitter) |
| LuaSnip | [GitHub](https://github.com/L3MON4D3/LuaSnip) |
| Friendly Snippets | [GitHub](https://github.com/rafamadriz/friendly-snippets) |
| Supermaven | [GitHub](https://github.com/supermaven-inc/supermaven-nvim) |
| Trouble | [GitHub](https://github.com/folke/trouble.nvim) |
| Lualine | [GitHub](https://github.com/nvim-lualine/lualine.nvim) |
| Indent Blankline | [GitHub](https://github.com/lukas-reineke/indent-blankline.nvim) |
| Neogen | [GitHub](https://github.com/danymat/neogen) |
| Mason | [GitHub](https://github.com/mason-org/mason.nvim) |
| Mason LSP Config | [GitHub](https://github.com/mason-org/mason-lspconfig.nvim) |
| nvim-cmp | [GitHub](https://github.com/hrsh7th/nvim-cmp) |

---

**End of Neovim Configuration Documentation**

This document covers the discussed plugins, keybindings, installation commands, and maintenance workflow. Before treating v1.0.0 as fully tested, verify the LSP setup, completion mappings, plugin versions, and terminal-specific shortcuts.