"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/howyay/.local/share/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/home/howyay/.local/share/dein')

" Let dein manage dein
" Required:
call dein#add('/home/howyay/.local/share/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
" call dein#add('preservim/nerdtree')
" call dein#add('ms-jpq/chadtree')
" call dein#add('kyazdani42/nvim-tree.lua')
call dein#add('ms-jpq/coq.artifacts')
" call dein#add('glepnir/dashboard-nvim')
" call dein#add('jose-elias-alvarez/null-ls.nvim')
call dein#add('lewis6991/impatient.nvim')
call dein#add('ms-jpq/coq_nvim')
call dein#add('wsdjeg/dein-ui.vim')
call dein#add('karb94/neoscroll.nvim')
call dein#add('petertriho/nvim-scrollbar')
call dein#add('nvim-treesitter/nvim-treesitter')
call dein#add('SmiteshP/nvim-gps')
call dein#add('nvim-lualine/lualine.nvim')
call dein#add('yamatsum/nvim-cursorline')
call dein#add('kevinhwang91/nvim-hlslens')
call dein#add('nvim-lua/plenary.nvim')
call dein#add('nvim-telescope/telescope.nvim')
call dein#add('kyazdani42/nvim-web-devicons')
call dein#add('nyngwang/NeoRoot.lua')
call dein#add('numToStr/Comment.nvim')
call dein#add('neovim/nvim-lspconfig')
call dein#add('lukas-reineke/indent-blankline.nvim')
call dein#add('sainnhe/gruvbox-material')
call dein#add('akinsho/bufferline.nvim')
call dein#add('sudormrfbin/cheatsheet.nvim')
call dein#add('lewis6991/spellsitter.nvim')
call dein#add('dstein64/vim-startuptime')
call dein#add('kevinhwang91/rnvimr')
call dein#add('liuchengxu/vista.vim')
call dein#add('lewis6991/gitsigns.nvim')
call dein#add('sindrets/diffview.nvim')
call dein#add('ggandor/lightspeed.nvim')
call dein#add('goolord/alpha-nvim')
call dein#add('ibhagwan/fzf-lua')
call dein#add('sidebar-nvim/sidebar.nvim')
call dein#add('ii14/lsp-command')
call dein#add('folke/todo-comments.nvim')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" lua require('impatient')
lua require('impatient').enable_profile()

set number
set guicursor=
set spell spelllang=en_us
set tabstop=4
set shiftwidth=4
set expandtab
set scrolloff=12
set virtualedit+=onemore
set mouse=a

let g:coq_settings = { 'auto_start': 'shut-up', 'clients.tabnine.enabled': v:true, 'clients.snippets.warn': ['outdated']}

let g:vista_icon_indent = ["╰", "├"]
let g:vista_executive_for = {
  \ 'cpp': 'nvim_lsp',
  \ }

lua << EOF
require('spellsitter').setup()

require('Comment').setup()

require('neoscroll').setup()

require("scrollbar").setup()
require("scrollbar.handlers.search").setup()

require("nvim-gps").setup()

require("sidebar-nvim").setup()

-- require'alpha'.setup(require'alpha.themes.dashboard'.opts)

require'fzf-lua'.setup {
    fzf_bin = 'sk',
    -- live_grep = {
    --     rg_opts = "--color=never --files --hidden --follow -g '!.ccls-cache'",
    -- }
}

require("cheatsheet").setup {
    include_only_installed_plugins = false,
}

local coq = require 'coq'
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- local util = require 'lspconfig.util'
-- capabilities.offsetEncoding = { "utf-16" }
-- require('lspconfig').clangd.setup {capabilities = capabilities }
require'lspconfig'.vimls.setup{}

require('lspconfig').ccls.setup(coq.lsp_ensure_capabilities({
  init_options = {
    cache = {
      directory = ".ccls-cache";
    };
  }
}))

-- require('lspconfig').denols.setup {}
--
-- require('nvim-treesitter.configs').setup {
--     highlight = {
--         enable = true,
--     },
-- }

require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "all",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  -- ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    -- disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    -- additional_vim_regex_highlighting = false,
  },
}

local gps = require("nvim-gps")

require('lualine').setup {
    options = {
        theme = 'gruvbox-material'
	},
    sections = {
		lualine_c = {
		    { gps.get_location, cond = gps.is_available },
		}
	}
}

require('gitsigns').setup {
    signs = {
        add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '*', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
}

require("indent_blankline").setup {
    filetype_exclude = { "dashboard", "vista", "vista_kind", "alpha" }, 
    buftype_exclude = { "terminal" }
}

require('bufferline').setup { 
    options = {
        show_buffer_close_icons = false,
        show_close_icon = false
    }
}
EOF

lua << EOF
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣤⣴⣦⣤⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
    '⠀⠀⠀⠀⠀⠀⢀⣤⣾⣿⣿⣿⣿⠿⠿⠿⠿⣿⣿⣿⣿⣶⣤⡀⠀⠀⠀⠀⠀⠀ ',
    '⠀⠀⠀⠀⣠⣾⣿⣿⡿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⢿⣿⣿⣶⡀⠀⠀⠀⠀ ',
    '⠀⠀⠀⣴⣿⣿⠟⠁⠀⠀⠀⣶⣶⣶⣶⡆⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣦⠀⠀⠀ ',
    '⠀⠀⣼⣿⣿⠋⠀⠀⠀⠀⠀⠛⠛⢻⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣧⠀⠀ ',
    '⠀⢸⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⡇⠀ ',
    '⠀⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⠀ ',
    '⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⡟⢹⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⣹⣿⣿⠀ ',
    '⠀⣿⣿⣷⠀⠀⠀⠀⠀⠀⣰⣿⣿⠏⠀⠀⢻⣿⣿⡄⠀⠀⠀⠀⠀⠀⣿⣿⡿⠀ ',
    '⠀⢸⣿⣿⡆⠀⠀⠀⠀⣴⣿⡿⠃⠀⠀⠀⠈⢿⣿⣷⣤⣤⡆⠀⠀⣰⣿⣿⠇⠀ ',
    '⠀⠀⢻⣿⣿⣄⠀⠀⠾⠿⠿⠁⠀⠀⠀⠀⠀⠘⣿⣿⡿⠿⠛⠀⣰⣿⣿⡟⠀⠀ ',
    '⠀⠀⠀⠻⣿⣿⣧⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⠏⠀⠀⠀ ',
    '⠀⠀⠀⠀⠈⠻⣿⣿⣷⣤⣄⡀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⠟⠁⠀⠀⠀⠀ ',
    '⠀⠀⠀⠀⠀⠀⠈⠛⠿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⠁⠀⠀⠀⠀⠀⠀ ',
    '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠛⠛⠛⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "  > Find file", ":cd $HOME | FzfLua files<CR>"),
    dashboard.button( "w", "  > Find word"   , ":FzfLua live_grep<CR>"),
    dashboard.button( "r", "  > Recent"   , ":FzfLua oldfiles<CR>"),
    dashboard.button( "m", "  > Bookmarks"   , ":FzfLua marks<CR>"), 
    dashboard.button( "c", "  > Colorscheme"   , ":FzfLua colorschemes<CR>"),
    dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
    dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),
}

-- Set footer
--   NOTE: This is currently a feature in my fork of alpha-nvim (opened PR #21, will update snippet if added to main)
--   To see test this yourself, add the function as a dependecy in packer and uncomment the footer lines
--   ```init.lua
--   return require('packer').startup(function()
--       use 'wbthomason/packer.nvim'
--       use {
--           'goolord/alpha-nvim', branch = 'feature/startify-fortune',
--           requires = {'BlakeJC94/alpha-nvim-fortune'},
--           config = function() require("config.alpha") end
--       }
--   end)
--   ```
-- local fortune = require("alpha.fortune")
-- dashboard.section.footer.val = fortune()

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
-- vim.cmd([[
--     autocmd FileType alpha setlocal nofoldenable
-- ]])
EOF

noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap * *<Cmd>lua require('hlslens').start()<CR>
noremap # #<Cmd>lua require('hlslens').start()<CR>
noremap g* g*<Cmd>lua require('hlslens').start()<CR>
noremap g# g#<Cmd>lua require('hlslens').start()<CR>

" use : instead of <Cmd>
nnoremap <silent> <leader>l :noh<CR>

let g:cursorline_timeout = 100

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('fzf-lua').files()<cr>
nnoremap <leader>fg <cmd>lua require('fzf-lua').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('fzf-lua').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('fzf-lua').help_tags()<cr>

set termguicolors

" Important!!
if has('termguicolors')
    set termguicolors
endif

set background=dark
let g:gruvbox_material_palette = 'mix'
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_italic = 0
let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_transparent_background = 1
colorscheme gruvbox-material

highlight link RnvimrNormal CursorLine

nnoremap <silent> <M-o> :RnvimrToggle<CR>
tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>
tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>

tnoremap <silent> <Esc> <C-\><C-n>

let g:rnvimr_enable_ex = 1
let g:rnvimr_enable_picker = 1

nnoremap <silent> <leader>cp :lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <leader>cv :Vista!!<CR>

nnoremap <silent>b] :BufferLineCycleNext<CR>
nnoremap <silent>b[ :BufferLineCyclePrev<CR>

