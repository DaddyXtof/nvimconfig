GuiFont! FiraCode NF:h18
" Full screen toggler mapped to F11
map <F11> :call MaximizeToggle()<CR>
let s:ismaximised = 0
function! MaximizeToggle()
   let s:ismaximised = !s:ismaximised
   call GuiWindowFullScreen(s:ismaximised)
endfunction

let s:fontsize = 12
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  :execute "GuiFont! FiraCode NF:h" . s:fontsize
endfunction

noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a
