-- wrapper for vim.keymap.set(mode, l, r, opts)
local function map(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

-- Open Neotree
map("n", "<leader>N", "<cmd>Neotree<cr>", { desc = "Open Neotree" })

-- Remap for dealing with visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Keep selection while indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Cancel search highlighting with ESC
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch and ESC" })

-- window
map("n", "<leader>ws", "<cmd>split<cr>", { desc = "Horizontal split" })
map("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", "<leader>wc", "<cmd>close<cr>", { desc = "Close" })
-- map("n", "<leader>wT", "<cmd>wincmd T<cr>", { desc = "Move window to new tab" })
-- map("n", "<leader>wr", "<cmd>wincmd r<cr>", { desc = "rotate down/right" })
-- map("n", "<leader>wR", "<cmd>wincmd R<cr>", { desc = "rotate up/left" })
-- map("n", "<leader>wH", "<cmd>wincmd H<cr>", { desc = "Move left" })
-- map("n", "<leader>wJ", "<cmd>wincmd J<cr>", { desc = "Move down" })
-- map("n", "<leader>wK", "<cmd>wincmd K<cr>", { desc = "Move up" })
-- map("n", "<leader>wL", "<cmd>wincmd L<cr>", { desc = "Move right" })
-- map("n", "<leader>w=", "<cmd>wincmd =<cr>", { desc = "Equalize size" })
-- map("n", "<leader>wk", "<cmd>resize +5<cr>", { desc = "Up" })
-- map("n", "<leader>wj", "<cmd>resize -5<cr>", { desc = "Down" })
-- map("n", "<leader>wh", "<cmd>vertical resize +3<cr>", { desc = "Left" })
-- map("n", "<leader>wl", "<cmd>vertical resize -3<cr>", { desc = "Right" })

-- buffers
map("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<leader>bD", "<cmd>%bd|e#|bd#<cr>", { desc = "Close all but the current buffer" })

-- new file
-- map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })
-- save file
-- map("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save file" })
-- open path under cursor
-- map("n", "<leader>fo", "gf", { desc = "Open path under cursor" })
