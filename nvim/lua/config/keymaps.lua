-- Move selected lines with shift+j or shift+k
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Copy contents of a function
vim.keymap.set("n", "YY", "va{Vy")

-- Join line while keeping the cursor in the same position
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor centred while scrolling up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Next and previous instance of the highlighted letter
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Better paste (prevents new paste buffer)
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete to void register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Fixed ctrl+c weirdness to exit from vertical select mode
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Delete shift+q keymap
vim.keymap.set("n", "Q", "<nop>")

-- Search and replace current position word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Oil
vim.keymap.set("n", "<leader>e", "<cmd>lua require('oil').toggle_float()<CR>", { desc = "Oil" })

-- Navigate buffers with Ctrl + arrow keys
vim.keymap.set("n", "<C-Right>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<C-Left>", ":bprevious<CR>", { silent = true })

-- Lazy menu
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { silent = true })
