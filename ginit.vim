" GuiFont! FiraCode NF:h18
" GuiFont! Fira Mono:h12
" GuiFont ProggyCleanTT:h12:cANSI
" GuiFont Terminus:h14:cANSI
"
" Full screen toggler mapped to F11
colorscheme gruvbox

map <F11> :call MaximizeToggle()<CR>
let s:ismaximised = 0
function! MaximizeToggle()
   let s:ismaximised = !s:ismaximised
   call GuiWindowFullScreen(s:ismaximised)
endfunction

" Old font increase decrease logic
let s:fontsize = 13
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  :execute "GuiFont! Terminus:h" . s:fontsize
endfunction
noremap  <C-ScrollWheelUp>   :call AdjustFontSize(1)<CR>
noremap  <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp>   <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a

"Enable context menu
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv

" Disable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 0
endif

" Auxiliary Functions:
if exists('*trim')
  let s:Trim = function('trim')
else
  function! s:Trim(input_string, ...)
      let s:mask = a:0 > 0 ? a:1 : '\s'
      let s:mask = '\['.s:mask.'\]'
      let s:regex = '^'.s:mask.'*\(.\{-}\)'.s:mask.'*$'
      return substitute(a:input_string, s:regex, '\1', '')
  endfunction
end

" NVIM Qt:
function! s:nvim_qt_get_font()
  let font = s:Trim(execute('GuiFont'))
  let font = split(font, ':h')
  let name = font[0]
  let size = s:Trim(font[1], ':hsb')
  return [name, size]
endfunction

function! s:nvim_qt_set_font(name, size)
  execute('GuiFont! '.a:name.':h'.a:size)
endfunction

" General:
function! GetFont()
  let l:Getter = get(g:font_manipulation, g:distribution)[0]
  return l:Getter()
endfunction

function! SetFont(name, ...)
  let l:Setter = get(g:font_manipulation, g:distribution)[1]
  if a:0 > 0
    let size = a:1
  else
    let size = GetFont()[1]
  endif
  return l:Setter(a:name, size)
endfunction

function! IncreaseFont(...)
  let increment = a:0 > 0 ?
      \ a:1 : get(b:, 'font_increment', g:font_increment)
  let font = GetFont()
  let name = font[0]
  let size = font[1]
  return SetFont(name, size + increment)
endfunction

function! DecreaseFont(...)
  let increment = a:0 > 0 ?
      \ a:1 : get(b:, 'font_increment', g:font_increment)
  let font = GetFont()
  let name = font[0]
  let size = font[1]
  echom 'Size: '.size.' . Diff '.(size-increment)
  return SetFont(name, size - increment)
endfunction

function! DefaultFont()
  let font = get(g:default_font, g:distribution)
  return call('SetFont', font)
endfunction

function! FontSize(size)
  let font = GetFont()
  let name = font[0]
  return SetFont(name, a:size)
endfunction


" Meta Configuration:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:source_pro = 'Source Code Pro'
let s:fira = 'Fira Mono'
let g:distribution = 'nvim-qt' 
let s:terminus = 'Terminus'

let g:fallback_font = [s:source_pro, 12]
let g:default_font = {
  \'nvim-qt':  [s:fira, 12],
\ }
let g:font_manipulation = {
  \'nvim-qt':  [function('s:nvim_qt_get_font'), function('s:nvim_qt_set_font')],
\ }
let g:font_increment = 1

" Configurations:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('g:SetColorScheme')
  call g:SetColorScheme()
end

call DefaultFont()

" Key Bindings:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Font Size:
nnoremap <silent> <leader>+ :<c-u>call IncreaseFont()<cr>
nnoremap <silent> <leader>- :<c-u>call DecreaseFont()<cr>
nnoremap <silent> <leader>= :<c-u>call DefaultFont()<cr>

command! Fira call SetFont(s:fira)
