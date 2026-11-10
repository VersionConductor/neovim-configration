# Neovim Configuration Documentation

**Version:** 1.0.0  
**Editor:** Neovim 0.11+  
**Language:** Lua  
**Plugin Manager:** Lazy.nvim  
**Configuration Style:** Modular

---

# 1. Requirements & Installation

### Required tools

| Package | Purpose |
|---|---|
| [Neovim](https://neovim.io/) | Text editor |
| [Git](https://git-scm.com/) | Version control and plugin installation |
| [Node.js](https://nodejs.org/) | JavaScript language servers |
| [Python](https://www.python.org/) | Python development |
| [Go](https://go.dev/) | Go development |
| [Make](https://www.gnu.org/software/make/) | Building native dependencies |
| [Ripgrep](https://github.com/BurntSushi/ripgrep) | Fast text searching |
| [fd](https://github.com/sharkdp/fd) | Fast file searching |
| C compiler | Tree-sitter parser compilation |

### Windows installation

```powershell
winget install Neovim.Neovim
winget install Git.Git
winget install OpenJS.NodeJS.LTS
winget install Python.Python.3.13
```

Verify:

```bash
nvim --version
git --version
node --version
npm --version
python --version
```

---

# 2. Directory Structure

```text
nvim/
├── init.lua
└── lua/
    └── custom/
        ├── lazy.lua
        ├── options.lua
        ├── keymaps.lua
        ├── autocmds.lua
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
```

---

# 3. Main Configuration

### Documentation: [Neovim Lua Guide](https://neovim.io/doc/user/lua-guide.html)

### `init.lua`

```lua
require("custom.lazy")
require("custom.options")
require("custom.keymaps")
require("custom.autocmds")
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

# 4. Neovim Options

Documentation: [Neovim Options](https://neovim.io/doc/user/options.html)

File: `lua/custom/options.lua`

```lua
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true

-- Line wrapping
opt.wrap = true
opt.scrolloff = 8
opt.colorcolumn = "80"

-- Search
opt.hlsearch = false
opt.incsearch = true

-- Files
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevelstart = 99

-- Cursor
opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- UI
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Performance
opt.updatetime = 50

-- Other
opt.isfname:append("@-@")

-- Window management
opt.splitright = true
opt.splitbelow = true

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
```

---

# 5. Keybindings

Documentation: [Neovim Lua Keymaps](https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings)

File: `lua/custom/keymaps.lua`

```lua
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set

-- General
map("n", "<leader>pv", "<cmd>Ex<CR>", { desc = "Open Explorer" })
map("n", "<leader><leader>", "<cmd>source %<CR>", {
    desc = "Reload Current File",
})
map("n", "Q", "<nop>")

-- Folding
map("n", "<leader>z", "za", { desc = "Toggle Fold" })
map("n", "<leader>o", "zo", { desc = "Open Fold" })
map("n", "<leader>c", "zc", { desc = "Close Fold" })

-- Neo-tree
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", {
    desc = "Toggle Explorer",
})

-- Move lines
map("n", "<leader>k", ":move-2<CR>==", {
    desc = "Move Line Up",
})
map("n", "<leader>j", ":move+<CR>==", {
    desc = "Move Line Down",
})
map("v", "<leader>k", ":move '<-2<CR>gv=gv", {
    desc = "Move Selection Up",
})
map("v", "<leader>j", ":move '>+<CR>gv=gv", {
    desc = "Move Selection Down",
})

-- Clipboard
map("x", "<leader>p", [["_dP]], {
    desc = "Paste Without Overwriting",
})
map({ "n", "v" }, "<leader>y", [["+y]], {
    desc = "Yank to Clipboard",
})
map("n", "<leader>Y", [["+Y]], {
    desc = "Yank Line to Clipboard",
})
map({ "n", "v" }, "<leader>d", [["_d]], {
    desc = "Delete Without Yanking",
})

-- Editing
map("i", "<C-c>", "<Esc>", {
    desc = "Escape Insert Mode",
})

map("n", "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace Word Under Cursor" }
)

map("n", "<leader>x", "<cmd>!chmod +x %<CR>", {
    silent = true,
    desc = "Make File Executable",
})

-- LSP
map("n", "<leader>f", function()
    vim.lsp.buf.format()
end, { desc = "Format Document" })

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

-- Go
map("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", {
    desc = "Insert Go Error Check",
})

-- Theme
map("n", "<leader>th", function()
    ThemeSelector()
end, { desc = "Select Colorscheme" })

-- Cellular Automaton
map("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", {
    desc = "Make It Rain",
})
```

---

# 6. Plugin Configurations

All files below belong in `lua/custom/lazy/`.

## 6.1 Treesitter

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
                "lua",
                "bash",
                "javascript",
                "typescript",
                "html",
                "css",
                "json",
                "php",
                "go",
                "python",
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

## 6.2 Telescope

Repository: [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

A fuzzy finder for files, buffers, Git files, and text searching.

```lua
return {
    "nvim-telescope/telescope.nvim",
    tag = "v0.2.0",

    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },

    config = function()
        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                file_ignore_patterns = {
                    "node_modules",
                    "%.git/",
                },

                mappings = {
                    i = {
                        ["<Esc>"] = require("telescope.actions").close,
                    },
                },
            },
        })

        telescope.load_extension("fzf")
    end,

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

## 6.3 Harpoon 2

Repository: [ThePrimeagen/Harpoon](https://github.com/ThePrimeagen/harpoon)

Harpoon allows you to bookmark important files and navigate between them quickly.

Your configuration uses the `harpoon2` branch.

```lua
return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",

    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        local map = vim.keymap.set

        -- Add files
        map("n", "<leader>A", function()
            harpoon:list():prepend()
        end, { desc = "Prepend Harpoon File" })

        map("n", "<leader>a", function()
            harpoon:list():add()
        end, { desc = "Add Harpoon File" })

        -- Harpoon menu
        map("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon Menu" })

        -- Select files
        map("n", "<C-h>", function()
            harpoon:list():select(1)
        end, { desc = "Harpoon File 1" })

        map("n", "<C-t>", function()
            harpoon:list():select(2)
        end, { desc = "Harpoon File 2" })

        map("n", "<C-n>", function()
            harpoon:list():select(3)
        end, { desc = "Harpoon File 3" })

        map("n", "<C-s>", function()
            harpoon:list():select(4)
        end, { desc = "Harpoon File 4" })

        -- Replace slots
        map("n", "<leader><C-h>", function()
            harpoon:list():replace_at(1)
        end, { desc = "Replace Harpoon Slot 1" })

        map("n", "<leader><C-t>", function()
            harpoon:list():replace_at(2)
        end, { desc = "Replace Harpoon Slot 2" })

        map("n", "<leader><C-n>", function()
            harpoon:list():replace_at(3)
        end, { desc = "Replace Harpoon Slot 3" })

        map("n", "<leader><C-s>", function()
            harpoon:list():replace_at(4)
        end, { desc = "Replace Harpoon Slot 4" })

        -- Navigate list
        map("n", "<C-S-P>", function()
            harpoon:list():prev()
        end, { desc = "Previous Harpoon Item" })

        map("n", "<C-S-N>", function()
            harpoon:list():next()
        end, { desc = "Next Harpoon Item" })
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

## 6.4 Vim Fugitive

Repository: [vim-fugitive](https://github.com/tpope/vim-fugitive)

A Git wrapper that integrates Git commands directly into Neovim.

```lua
return {
    "tpope/vim-fugitive",

    cmd = {
        "Git",
        "G",
    },

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

## 6.5 Neo-tree

Repository: [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)

Provides a graphical file explorer.

```lua
return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },

    cmd = "Neotree",

    keys = {
        {
            "<leader>e",
            "<cmd>Neotree toggle<CR>",
            desc = "Toggle File Explorer",
        },
    },

    opts = {},
}
```

## 6.6 LuaSnip

Repository: [LuaSnip](https://github.com/L3MON4D3/LuaSnip)

Provides code snippets and placeholder navigation.

```lua
return {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",

    dependencies = {
        "rafamadriz/friendly-snippets",
    },

    config = function()
        local ls = require("luasnip")

        require("luasnip.loaders.from_vscode").lazy_load()

        ls.filetype_extend("javascript", { "jsdoc" })

        local map = vim.keymap.set

        map("i", "<C-s>e", ls.expand, { silent = true })

        map({ "i", "s" }, "<C-s>;", function()
            ls.jump(1)
        end, { silent = true })

        map({ "i", "s" }, "<C-s>,", function()
            ls.jump(-1)
        end, { silent = true })

        map({ "i", "s" }, "<C-E>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, { silent = true })
    end,
}
```

### Shortcuts

| Shortcut | Action |
|---|---|
| `<C-s>e` | Expand snippet |
| `<C-s>;` | Next placeholder |
| `<C-s>,` | Previous placeholder |
| `<C-E>` | Change choice |

## 6.7 Supermaven

Repository: [Supermaven.nvim](https://github.com/supermaven-inc/supermaven-nvim)

AI-powered inline code completion.

```lua
return {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",

    opts = {
        keymaps = {
            accept_suggestion = "<Tab>",
            clear_suggestion = "<C-]>",
            accept_word = "<C-j>",
        },

        ignore_filetypes = {
            "bigfile",
            "snacks_input",
            "snacks_notif",
            "TelescopePrompt",
        },

        color = {
            suggestion_color = "#808080",
            cterm = 244,
        },

        log_level = "off",
        disable_inline_completion = false,
        disable_keymaps = false,
    },
}
```

### Shortcuts

| Shortcut | Action |
|---|---|
| `<Tab>` | Accept suggestion |
| `<C-]>` | Clear suggestion |
| `<C-j>` | Accept next word |

## 6.8 Trouble

Repository: [Trouble.nvim](https://github.com/folke/trouble.nvim)

Displays diagnostics, references, and other lists.

```lua
return {
    "folke/trouble.nvim",
    cmd = "Trouble",

    opts = {
        icons = false,
    },

    keys = {
        {
            "<leader>tt",
            "<cmd>Trouble diagnostics toggle<CR>",
            desc = "Toggle Diagnostics",
        },
        {
            "[t",
            function()
                require("trouble").previous({
                    skip_groups = true,
                    jump = true,
                })
            end,
            desc = "Previous Trouble Item",
        },
        {
            "]t",
            function()
                require("trouble").next({
                    skip_groups = true,
                    jump = true,
                })
            end,
            desc = "Next Trouble Item",
        },
    },
}
```

## 6.9 Lualine

Repository: [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)

```lua
return {
    "nvim-lualine/lualine.nvim",

    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    opts = {},
}
```

## 6.10 Indent Blankline

Repository: [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)

```lua
return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",

    opts = {
        indent = {
            char = "│",
        },
    },
}
```

## 6.11 Neogen

Repository: [Neogen](https://github.com/danymat/neogen)

Generates documentation comments.

```lua
return {
    "danymat/neogen",

    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },

    opts = {
        enabled = true,
        input_after_comment = true,
        snippet_engine = "luasnip",
    },

    keys = {
        {
            "<leader>nf",
            function()
                require("neogen").generate({ type = "func" })
            end,
            desc = "Function Documentation",
        },
        {
            "<leader>nc",
            function()
                require("neogen").generate({ type = "class" })
            end,
            desc = "Class Documentation",
        },
        {
            "<leader>nt",
            function()
                require("neogen").generate({ type = "type" })
            end,
            desc = "Type Documentation",
        },
        {
            "<leader>na",
            function()
                require("neogen").generate({ type = "file" })
            end,
            desc = "File Documentation",
        },
    },
}
```

---

# 7. LSP Configuration

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
| C/C++ | `clangd` |
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

# 8. Completion System

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

# 9. LSP Keybindings

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

# 10. Complete Keybinding Reference

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
| `<leader>ee` | Insert Go error check |

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

# 11. Installation and Maintenance

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

# 12. Troubleshooting

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

# 13. Git Versioning

Documentation: [Git Documentation](https://git-scm.com/doc)

Track your Neovim configuration using Git.

### First stable release

```bash
git add .
git commit -m "Initial stable Neovim configuration"

git tag -a v1.0.0 -m "First stable release"

git push origin main
git push origin v1.0.0
```

### Future versions

| Version | Purpose |
|---|---|
| `v1.0.0` | First stable release |
| `v1.0.1` | Bug fixes |
| `v1.1.0` | New features |
| `v2.0.0` | Breaking changes |

---

# 14. Official Documentation Index

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