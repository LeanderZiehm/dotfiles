vim.g.mapleader = " "
vim.g.maplocalleader = " "


vim.keymap.set("n", "<C-_>", function()
  vim.cmd("normal! gcc")
end, { noremap = true, silent = true })


-- jk or kj to escape insert mode
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("i", "kj", "<Esc>", { noremap = true, silent = true })


-- VSCODE LIKE 

-- MOVE LINE: ALT UP DOWN
vim.keymap.set('n', '<M-j>', ':m .+1<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', '<M-k>', ':m .-2<CR>==', { noremap = true, silent = true })
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('n', '<M-Down>', ':m .+1<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', '<M-Up>', ':m .-2<CR>==', { noremap = true, silent = true })
vim.keymap.set('v', '<M-Down>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', '<M-Up>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Toggle line wrap: ALT Z
vim.api.nvim_set_keymap('n', '<M-z>', ':set wrap! linebreak!<CR>', { noremap = true, silent = true })


-- vim.keymap.set({'n','v'}, '<leader>d', '"_d', { noremap = true, silent = true })
-- vim.keymap.set({'n','v'}, 'd', '"_d', { noremap = true, silent = true })


-- VSCODE PASTE AND COPY: CTRL V and CTRL C
vim.keymap.set('i', '<C-v>', '<C-r>+', { silent = true })
vim.keymap.set('n', '<C-v>', '"+p', { silent = true })
vim.keymap.set('v', '<C-v>', '"+p', { silent = true })

-- Function to copy like VSCode
local function copy_like_vscode()
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "\22" then
    -- If something is visually selected, yank it
    vim.cmd('normal! "+y')
  else
    -- If nothing is selected, yank the whole line
    vim.cmd('normal! "+yy')
  end
end
-- Map Ctrl-C in normal and visual mode
vim.keymap.set({'n','v'}, '<C-c>', copy_like_vscode, { silent = true })




-- Trigger omni-completion or keyword completion with Ctrl+.
vim.keymap.set("i", "<C-.>", "<C-n>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-.>', '<C-n>', { noremap = true, silent = true })

-- Smart Tab for insert mode completion
vim.keymap.set("i", "<Tab>", function()
    if vim.fn.pumvisible() == 1 then
        return vim.api.nvim_replace_termcodes("<C-n>", true, true, true)
    else
        return "\t"
    end
end, { expr = true, noremap = true })

vim.keymap.set("i", "<S-Tab>", function()
    if vim.fn.pumvisible() == 1 then
        return vim.api.nvim_replace_termcodes("<C-p>", true, true, true)
    else
        return "\b"
    end
end, { expr = true, noremap = true })

-- Restore cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')  -- '"' is the last position mark
        local line = mark[1]
        local col = mark[2]
        local last_line = vim.api.nvim_buf_line_count(0)
        if line > 0 and line <= last_line then
            vim.api.nvim_win_set_cursor(0, { line, col })
        end
    end,
})



-- Clean escape from terminal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { silent = true })
-- Terminal toggle with Ctrl-J
local term_buf = nil
local term_win = nil

local function toggle_terminal()
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, true)
    term_win = nil
    return
  end

  vim.cmd("botright split")
  vim.cmd("resize 15")

  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    vim.api.nvim_win_set_buf(0, term_buf)
  else
    vim.cmd("terminal")
    term_buf = vim.api.nvim_get_current_buf()
  end

  term_win = vim.api.nvim_get_current_win()
  vim.cmd("startinsert")
end

vim.keymap.set("n", "<C-j>", toggle_terminal, { silent = true, desc = "Toggle terminal" })
vim.keymap.set("t", "<C-j>", toggle_terminal, { silent = true, desc = "Toggle terminal" })


-- =========================================================
-- Core UI
-- =========================================================
vim.opt.number = true
-- vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
-- vim.opt.colorcolumn = "100"
vim.opt.termguicolors = true

-- =========================================================
-- Clipboard & Mouse
-- =========================================================
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"

-- =========================================================
-- Indentation (TS / React friendly, adjust to 4 for Python if needed)
-- =========================================================
-- vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
-- vim.opt.smartindent = true

-- =========================================================
-- Search
-- =========================================================
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
-- # hi 
-- ## nice 
-- ### wow
-- #### nice 

-- =========================================================
-- Splits
-- =========================================================
vim.opt.splitbelow = true
vim.opt.splitright = true

-- =========================================================
-- Scrolling & Navigation
-- =========================================================
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

-- =========================================================
-- Performance & Responsiveness
-- =========================================================
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400
vim.opt.ttimeoutlen = 10

-- =========================================================
-- Text Rendering
-- =========================================================
vim.opt.wrap = false
vim.opt.linebreak = true

-- =========================================================
-- Completion UX
-- =========================================================
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- =========================================================
-- File Handling
-- =========================================================
vim.opt.hidden = true
vim.opt.confirm = true
vim.opt.autoread = true

-- =========================================================
-- Whitespace Visualization
-- =========================================================
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  trail = "·",
  nbsp = "␣",
}

-- =========================================================
-- Backspace Behavior
-- =========================================================
vim.opt.backspace = { "start", "eol", "indent" }

-- =========================================================
-- Unified swap / undo / backup directories
-- =========================================================



-- Base data directory (cross-platform safe)
local data_dir = vim.fn.stdpath('data')

-- Ensure directory exists helper
local function ensure_dir(dir)
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, 'p')
  end
end

-- === Undo ===
local undo_dir = data_dir .. '/undo'
ensure_dir(undo_dir)
vim.o.undofile = true
vim.o.undodir = undo_dir

-- === Swap ===
local swap_dir = data_dir .. '/swap'
ensure_dir(swap_dir)
vim.o.directory = swap_dir

-- === Backup ===
local backup_dir = data_dir .. '/backup'
ensure_dir(backup_dir)
vim.o.backup = true
vim.o.writebackup = true
vim.o.backupdir = backup_dir

-- Optional: more sane defaults
vim.o.undolevels = 1000
vim.o.undoreload = 10000
vim.o.backupcopy = 'yes'  -- avoid issues with some tools like git
--



--- SURROUND WITH CODE TO REPLACE PLUGIN: SURROUNT WITH
local function surround_selection(left, right)
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.api.nvim_buf_get_lines(0, start_pos[2]-1, end_pos[2], false)

  -- Add left/right to first/last line
  lines[1] = string.rep(left, 1) .. lines[1]
  lines[#lines] = lines[#lines] .. string.rep(right, 1)

  vim.api.nvim_buf_set_lines(0, start_pos[2]-1, end_pos[2], false, lines)
end

vim.keymap.set("v", "'", function() surround_selection("'", "'") end, { desc = "Surround selection with '" })
vim.keymap.set("v", '"', function() surround_selection('"', '"') end, { desc = 'Surround selection with "' })
vim.keymap.set("v", '`', function() surround_selection('`', '`') end, { desc = "Surround selection with `" })
vim.keymap.set("v", '{', function() surround_selection('{', '}') end, { desc = "Surround selection with {" })
vim.keymap.set("v", '[', function() surround_selection('[', ']') end, { desc = "Surround selection with [" })
vim.keymap.set("v", '(', function() surround_selection('(', ')') end, { desc = "Surround selection with (" })
vim.keymap.set("v", '<', function() surround_selection('<', '>') end, { desc = "Surround selection with <" })


-- Backspace



vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup({
  -- 'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically
  


	-- TOKYONIGHT
	{ -- You can easily change to a different colorscheme.
	   'folke/tokyonight.nvim',
	   priority = 1000, -- Make sure to load this before all the other start plugins.
	   config = function()
	     require('tokyonight').setup {
	       styles = {
	         comments = { italic = false }, -- Disable italics in comments
	       },
	     }
	     vim.cmd.colorscheme 'tokyonight-night'
	   end,
	 },
-- FLUOROMACHINE
	{
			'maxmx03/fluoromachine.nvim',
			lazy = false,
			priority = 1000,
			config = function ()
			 local fm = require 'fluoromachine'

			 fm.setup {
					glow = false,
					theme = 'fluoromachine',
					transparent = true,
			 }
			 -- vim.cmd.colorscheme 'fluoromachine'
			end
	},
-- {
--     'tanvirtin/monokai.nvim',
--     lazy = false,       -- load immediately
--     priority = 1000,    -- load before other plugins
--     config = function()
--         local monokai = require('monokai')
--         -- Optional: choose a palette
--         local palette = monokai.classic
--         -- Setup the colorscheme
--         monokai.setup({
--             palette = palette,  -- you can also use monokai.pro, monokai.soda, monokai.ristretto
--             italics = false,    -- disable italics if you prefer
--             custom_hlgroups = {
--                 TSInclude = { fg = palette.aqua },
--                 GitSignsAdd = { fg = palette.green, bg = palette.base2 },
--                 GitSignsDelete = { fg = palette.pink, bg = palette.base2 },
--                 GitSignsChange = { fg = palette.orange, bg = palette.base2 },
--             },
--         })
--
--         -- Apply the colorscheme
--         -- vim.cmd.colorscheme 'monokai'
--     end,
-- },
-- TREE SITTER
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },



-- TELESCOPE
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
      pickers = {
        colorscheme = {
          enable_preview = true
        }
      },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>cs', builtin.colorscheme, { desc = '[C]olor [S]chemes' })
      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
  -- { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
--- WHICH KEY
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 3000,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },




{
  "neovim/nvim-lspconfig"
},

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

})

