-- import telescope plugin safely
local builtin_setup, builtin= pcall(require, "telescope.builtin")
if not builtin_setup then
  return
end

vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
