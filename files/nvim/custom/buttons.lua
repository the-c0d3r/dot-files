local tabufline_modules = require "nvchad_ui.tabufline.modules"

vim.cmd "function! JumpBackward(a,b,c,d) \n lua vim.cmd(vim.api.nvim_replace_termcodes('normal <C-o>',true,true,true)) \n endfunction"
vim.cmd "function! JumpForward(a,b,c,d) \n lua vim.cmd(vim.api.nvim_replace_termcodes('normal 1<C-i>',true,true,true)) \n endfunction"

return {
    buttons = function()
        local jmp_fwd_btn = "%@JumpForward@%#TblineTabNewBtn#" .. " › " .. "%X"
        local jmp_bwd_btn = "%@JumpBackward@%#TblineTabNewBtn#" .. " ‹ " .. "%X"
        return jmp_bwd_btn .. jmp_fwd_btn .. tabufline_modules.buttons()
    end,
}
