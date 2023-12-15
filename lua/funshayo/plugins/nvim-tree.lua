-- import nvim-tree plugin safely
local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
    return
end

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- configure nvim-tree
nvimtree.setup({
    -- disable window_picker for explorer to work well with window splits
    actions = {
        open_file = {
            window_picker = {
                enable = false,
            },
        },
    },
    filters = {
        dotfiles = true,
    },
     	git = {
     		ignore = true,
     	},
    view = {
        side = "right"
    }
})
