"=======================
"===Plugin Management===
"=======================
"only usable in local
"set nocompatible
"filetype off
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"Plugin 'VundleVim/Vundle.vim'
"call vundle#end()
"filetype plugin indent on
"Plugin 'suoto/vim-hdl'

"=================
"===Key Mapping===
"=================
nmap <f2> :tabnew $MYVIMRC<cr>
nmap <f4> :source $MYVIMRC<cr>
nmap <f3> :call WrapToggle()<cr>
nmap <c-n> :noh<cr>
nmap <c-h> gT
nmap <c-j> gt
nmap qq :q<cr>
nmap fnv :call FillNumVisual()
nmap vdsp :vert diffsplit 
nmap * *``
nmap zdep1 :'<,'>s/^\s*\(\w*\) \s*\(\w*\)\s*,*\s*$/\2 .: \1 .std_logic .;/<cr>
nmap zdep2 :'<,'>s/^\s*\(\w*\) \s*\[\s*\(\d*\)\s*:\s*\(\d*\)\s*\] \s*\(\w*\)\s*,*\s*$/\4 .: \1 .std_logic_vector (\2 downto \3) .;/<cr>
nmap zdes2 :'<,'>s/^\s*wire \s*\[\s*\(\d*\)\s*:\s*\(\d*\)\s*\] \s*\(\w*\)\s*;\s*$/signal \3 .: .std_logic_vector (\1 downto \2)  .;/<cr>
nmap zdew1 :'<,'>s/\(\w*\) \s*: \s*in \s*std_logic \s*;/wire .w_\1 .;/<cr>
nmap zdew2 :'<,'>s/\(\w*\) \s*: \s*in \s*std_logic_vector\s*(\([0-9]*\) \s*downto \s*\([0-9]*\)) \s*;/wire [\2:\3] .w_\1 .;/<cr>
nmap <c-c> mfmc
nmap <c-p> mt
nmap zp "0p
nmap ss :mks 
nmap zn ]c
nmap zb [c
nnoremap (  :call CplBrac("(",")")<cr>
nnoremap [  :call CplBrac("[","]")<cr>
nnoremap {  :call CplBrac("{","}")<cr>
nnoremap <  :call CplBrac("<",">")<cr>
nnoremap '  :call CplBrac("'","'")<cr>
"nnoremap "  :call CplBrac("\"","\"")<cr>
"vmap zcb1 :call CplBrac("(")<cr>
"vmap zcb2 :call CplBrac("[")<cr>
"vmap zcb3 :call CplBrac("{")<cr>
vmap zhb yq:p:s/^/:call Hex2bin_core("/<cr>:s/$/")/<cr><cr>
vmap zhd yq:p:s/^/:call Hex2dec_core("/<cr>:s/$/")/<cr><cr>
vmap zbh yq:p:s/^/:call Bin2hex_core("/<cr>:s/$/")/<cr><cr>
vmap zbd yq:p:s/^/:call Bin2dec_core("/<cr>:s/$/")/<cr><cr>
vmap zdb yq:p:s/^/:call Dec2bin_core("/<cr>:s/$/")/<cr><cr>
vmap zdh yq:p:s/^/:call Dec2hex_core("/<cr>:s/$/")/<cr><cr>
vmap <c-o> yq:p:s/^/:tabnew /<cr><cr>
vmap zct   :s/\t/    /g<cr>
vmap zp "0p
vnoremap (  :call CplBrac("(",")")<cr>
vnoremap [  :call CplBrac("[","]")<cr>
vnoremap {  :call CplBrac("{","}")<cr>
vnoremap <  :call CplBrac("<",">")<cr>
vnoremap '  :call CplBrac("'","'")<cr>
"vnoremap "  :call CplBrac("\"","\"")<cr>
"vmap zcol  :s/\([\[|,|(|)|:|;|\]|=]\)/@\1/g<cr>:'<,'>!column -t -s"@"<cr>
"vmap zdep1 :s/^\s*\(\w*\) \s*\(\w*\)\s*,*\s*$/\2 .: \1 .std_logic .;/<cr>
"vmap zdep2 :s/^\s*\(\w*\) \s*\[\s*\(\d*\)\s*:\s*\(\d*\)\s*\] \s*\(\w*\)\s*,*\s*$/\4 .: \1 .std_logic_vector (\2 downto \3) .;/<cr>
"vmap zdes2 :s/^\s*wire \s*\[\s*\(\d*\)\s*:\s*\(\d*\)\s*\] \s*\(\w*\)\s*;\s*$/signal \3 .: .std_logic_vector (\1 downto \2)  .;/<cr>

inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-h> <left>
inoremap <c-l> <right>
inoremap @dt downto
inoremap @proc <esc>:call InsertProcess()<cr>
inoremap (( ()<left>
inoremap [[ []<left>
inoremap {{ {}<left>
inoremap "" ""<left>
inoremap '' ''<left>
inoremap << <><left>
inoremap @ver [add/modify/remove]<esc>oversion:0x00??<cr>by zeng@2021.??.??<esc>
"imap ' ''<c-h>
inoremap <c-c> <esc>
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"

"================
"===Preference===
"================
set number
set tabstop=4
set expandtab
set hlsearch incsearch 
set cursorline
set listchars=tab:..
set list
highlight DiffAdd    cterm=bold ctermfg=15 ctermbg=34
highlight DiffDelete cterm=bold ctermfg=15 ctermbg=219
highlight DiffChange cterm=bold ctermfg=15 ctermbg=75
highlight DiffText   cterm=bold ctermfg=15 ctermbg=99
highlight Search     cterm=bold ctermfg=226 ctermbg=130
highlight incsearch  cterm=bold ctermfg=226 ctermbg=130
highlight NonText    cterm=none ctermfg=240 ctermbg=0
highlight SpecialKey cterm=None ctermfg=240 ctermbg=0
highlight Pmenu      ctermbg=0 ctermfg=241
highlight PmenuSel   ctermbg=4
highlight PmenuSbar  ctermbg=2
highlight PmenuThumb ctermfg=3

autocmd BufNewFile,BufRead *.json set ft=javascript
"autocmd BufNewFile,BufRead *.v    :call SwVerilogMode(1)<cr>
"autocmd FileType v,sv    call SwVerilogMode(1)<cr>
"autocmd FileType v,sv    execute ":normal a This is a HDL file\<Esc>"
"autocmd BufNewFile,BufRead *.v  execute ":normal i This is a HDL file"

if &term =~ "xterm"
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[2 q"
endif

"0p

"==================
"===User command===
"==================
command! Updrc  :source $MYVIMRC
command! Updrcr :source ~/zeng/.vimrc

"===================
"===User function===
"===================

function! WrapToggle()
    if &wrap
        setlocal nowrap
    else
        setlocal wrap
    endif
endfunction

function! EchoVisualPos()
    :normal `<
    :echo line(".")
    :echo col(".")
    "# => echo begin position
    
    :normal `>
    :echo line(".")
    :echo col(".")
    ""# => echo end position
endfunction

function! FillNumVisual(fill_num)
    :normal `<
    let line_offset = line(".")
    let col_offset  = col(".")
    :normal `>
    let line_end    = line(".")
    for line in range(line_offset, line_end)
        let pos = [0, line, col_offset, 0]
        let input = a:fill_num + line - line_offset
        :call setpos(".", pos)
        :execute ":normal i" . input . "\<Esc>"
        "echo line col_offset input
    endfor
endfunction

"function! Hex2bin()
"    q:p:s/^/:call Hex2bin_core("/<cr>:s/^/")/<cr><cr>
"endfunction

function! Hex2bin_core(hex_val)
    let hexval_u = toupper(a:hex_val)
    let input = hexval_u
    "echo input
    :execute ":!echo \"obase=2;ibase=16;" . input . "\" | bc"
endfunction

function! Hex2dec_core(hex_val)
    let hexval_u = toupper(a:hex_val)
    let input = hexval_u
    "echo input
    :execute ":!echo \"obase=10;ibase=16;" . input . "\" | bc"
endfunction

function! Bin2hex_core(bin_val)
    let binval_u = toupper(a:bin_val)
    let input = binval_u
    "echo input
    :execute ":!echo \"obase=16;ibase=2;" . input . "\" | bc"
endfunction

function! Bin2dec_core(bin_val)
    let binval_u = toupper(a:bin_val)
    let input = binval_u
    "echo input
    :execute ":!echo \"obase=10;ibase=2;" . input . "\" | bc"
endfunction

function! Dec2bin_core(dec_val)
    let decval_u = toupper(a:dec_val)
    let input = decval_u
    "echo input
    :execute ":!echo \"obase=2;ibase=10;" . input . "\" | bc"
endfunction

function! Dec2hex_core(dec_val)
    let decval_u = toupper(a:dec_val)
    let input = decval_u
    "echo input
    :execute ":!echo \"obase=16;ibase=10;" . input . "\" | bc"
endfunction

"function to complete (, {, [, <
function! CplBrac(b1,b2)
    :normal `<
    let line_offset = line(".")
    let col_offset  = col(".")
    ":echo line(".")
    ":echo col(".")
    :normal `>
    let line_end    = line(".")
    let col_end     = col(".")
    ":echo line(".")
    ":echo col(".")

    "insert left bracket
    let pos_offset = [0, line_offset, col_offset, 0]
    let input_offset = a:b1
    :call setpos(".", pos_offset)
    :execute ":normal i" . input_offset . "\<Esc>"

    "insert right bracket
    let pos_end = [0, line_end, col_end+1, 0]
    let input_end = a:b2
    :call setpos(".", pos_end)
    :execute ":normal a" . input_end . "\<Esc>"

endfunction

function! InsBrac(b1,b2)
    let line_offset = line(".")
    let col_offset  = col(".")
    echo getline('.')[col_offset]
    let right_char = getline('.')[col_offset]
    if right_char == '\w' 
        let input_offset = "("
    else
        let input_offset = "()"
    endif
    :execute ":normal i" . input_offset . "\<Esc>"
endfunction

function! InsertProcess()
    "let pos_ref = getpos(".")
    let line_offset = line(".")
    let pos1 = [0, line_offset  , 0, 0]
    let pos2 = [0, line_offset+1, 0, 0]
    let pos3 = [0, line_offset+2, 0, 0]
    let pos4 = [0, line_offset+3, 0, 0]
    let pos5 = [0, line_offset+4, 0, 0]
    let pos6 = [0, line_offset+5, 0, 0]
    let pos7 = [0, line_offset+6, 0, 0]
    let pos8 = [0, line_offset+7, 0, 0]
    let pos9 = [0, line_offset+8, 0, 0]
    let line1 = "PRO_NAME: "
    let line2 = "process(RSTN, CLK)"
    let line3 = "begin"
    let line4 = "   if (RSTN = '0') then"
    let line5 = "       REG_NAME <= '0' ;"
    let line6 = "   elsif (CLK'event and CLK = '1') then"
    let line7 = "       REG_NAME <= CONNECT ;"
    let line8 = "   end if ;"
    let line9 = "end process ;"
    :call setpos(".", pos1)
    :execute ":normal a" . line1 . "\<Esc>o\<Esc>"
    :call setpos(".", pos2)
    :execute ":normal a" . line2 . "\<Esc>o\<Esc>"
    :call setpos(".", pos3)
    :execute ":normal a" . line3 . "\<Esc>o\<Esc>"
    :call setpos(".", pos4)
    :execute ":normal a" . line4 . "\<Esc>o\<Esc>"
    :call setpos(".", pos5)
    :execute ":normal a" . line5 . "\<Esc>o\<Esc>"
    :call setpos(".", pos6)
    :execute ":normal a" . line6 . "\<Esc>o\<Esc>"
    :call setpos(".", pos7)
    :execute ":normal a" . line7 . "\<Esc>o\<Esc>"
    :call setpos(".", pos8)
    :execute ":normal a" . line8 . "\<Esc>o\<Esc>"
    :call setpos(".", pos9)
    :execute ":normal a" . line9 . "\<Esc>o\<Esc>"
endfunction

function! CheckSyntax()
    :execute ":normal /end if\s*$"
endfunction

function! SwVerilogMode(verilog_mode)
    if a:verilog_mode == "1"
        inoremap @mod   module XXX(<cr><esc>A);<cr>endmodule<esc>kkA
        inoremap @alw   always @ (posedge CLK or negedge RSTN) begin<cr>end<cr>
        inoremap @if    if () begin<cr>end else begin<cr>end
        inoremap @gen   generate<cr>endgenerate<cr>
        inoremap @for   integer var;<cr>for(var=0; var<; var++) begin<cr>end<cr>
        inoremap @init  initial begin<cr>end<cr>
        inoremap @repe  repeat () @ (posedge CLK);<esc>
        inoremap @task  task task_name;<cr>begin<cr>endtask<cr>
        vmap     zci    :s/\./#\./<cr>:'<,'>s/(/#(/<cr>:'<,'>s/)/#)/<cr>:'<,'>s/,/#,/<cr>:'<,'>!column -t -s"\#"<cr>
        "inoremap @ck  _|<esc>ki_<esc>ja|
        inoremap @ck  ___HHH
        inoremap @des   //============================================<cr>// (C) Copyright All rights reserved. Artiza networks Inc.<cr>//DESCRIPTION:<cr>//AUTHOR:Zeng<cr>//HISTORY<cr>//REV        EDITOR     DATE         DESCITPTION<cr>//============================================<cr>
        inoremap @begin begin<cr>end<cr>
        inoremap @case  case (XXX)<cr>YYY:begin<cr>end<cr>default:<cr>end<cr>endcase<cr>
        inoremap @fpck  set_false_path -from [get_clocks -of_objects [get_pins PATH_CLOCK1]] -to [get_clocks -of_objects [get_pins PATH_CLOCK2]]
        inoremap @fpdt  set_false_path -from [get_pins {PATH_START}] -to [get_pins {PATH_END}]
    else
        iunmap @mod
        iunmap @alw
        iunmap @if
        iunmap @gen
        iunmap @for
        iunmap @init
        vunmap zci
        iunmap @ck
        iunmap @des
        iunmap @begin 
        iunmap @case 
        iunmap @fpck 
        iunmap @fpdt 
    endif
endfunction 

function! SwPerlMode(perl_mode)
    if a:perl_mode == "1"
        inoremap @des   #============================================<cr># (C) Copyright All rights reserved. Artiza networks Inc.<cr>#DESCRIPTION:<cr>#AUTHOR:Zeng<cr>#HISTORY<cr>#REV        EDITOR     DATE         DESCITPTION<cr>#============================================<cr>
        inoremap $  ${}<left>
        inoremap @for   for (my ${cnt}=0; ${cnt}<xx; ${cnt}++) {<cr>}<cr><up><up>
    else
        iunmap @des
        iunmap $
    endif
endfunction 

function! SwVhdlMode(vhdl_mode)
    if a:vhdl_mode == "1"
        inoremap @proc  <esc>:call InsertProcess()<cr>
    else
        unmap @proc
    endif
endfunction 
"=================================
"=== FUNRCTION TO BE IMPLEMENT ===
"=================================
"function to generate vector from signal name, msb, lsb
"function to insert ILA connect

"===============================
"=== AUTO COMPLETION SETTING ===
"===============================
" vim: set noet fenc=utf-8 ff=unix sts=4 sw=4 ts=4 :
"
" apc.vim - auto popup completion window
"
" Created by skywind on 2020/03/05
" Last Modified: 2021/03/11 08:45
"
" Features:
"
" - auto popup complete window without select the first one
" - tab/s-tab to cycle suggestions, <c-e> to cancel
" - use ApcEnable/ApcDisable to toggle for certiain file.
"
" Usage:
"
" set cpt=.,k,b
" set completeopt=menu,menuone,noselect
" let g:apc_enable_ft = {'text':1, 'markdown':1, 'php':1}

let g:apc_enable_ft = get(g:, 'apc_enable_ft', {})    " enable filetypes
let g:apc_enable_tab = get(g:, 'apc_enable_tab', 1)   " remap tab
let g:apc_min_length = get(g:, 'apc_min_length', 2)   " minimal length to open popup
let g:apc_key_ignore = get(g:, 'apc_key_ignore', [])  " ignore keywords

" get word before cursor
function! s:get_context()
    return strpart(getline('.'), 0, col('.') - 1)
endfunc

function! s:meets_keyword(context)
    if g:apc_min_length <= 0
        return 0
    endif
    let matches = matchlist(a:context, '\(\k\{' . g:apc_min_length . ',}\)$')
    if empty(matches)
        return 0
    endif
    for ignore in g:apc_key_ignore
        if stridx(ignore, matches[1]) == 0
            return 0
        endif
    endfor
    return 1
endfunc

function! s:check_back_space() abort
      return col('.') < 2 || getline('.')[col('.') - 2]  =~# '\s'
endfunc

function! s:on_backspace()
    if pumvisible() == 0
        return "\<BS>"
    endif
    let text = matchstr(s:get_context(), '.*\ze.')
    return s:meets_keyword(text)? "\<BS>" : "\<c-e>\<bs>"
endfunc


" autocmd for CursorMovedI
function! s:feed_popup()
    let enable = get(b:, 'apc_enable', 0)
    let lastx = get(b:, 'apc_lastx', -1)
    let lasty = get(b:, 'apc_lasty', -1)
    let tick = get(b:, 'apc_tick', -1)
    if &bt != '' || enable == 0 || &paste
        return -1
    endif
    let x = col('.') - 1
    let y = line('.') - 1
    if pumvisible()
        let context = s:get_context()
        if s:meets_keyword(context) == 0
            call feedkeys("\<c-e>", 'n')
        endif
        let b:apc_lastx = x
        let b:apc_lasty = y
        let b:apc_tick = b:changedtick
        return 0
    elseif lastx == x && lasty == y
        return -2
    elseif b:changedtick == tick
        let lastx = x
        let lasty = y
        return -3
    endif
    let context = s:get_context()
    if s:meets_keyword(context)
        silent! call feedkeys("\<c-n>", 'n')
        let b:apc_lastx = x
        let b:apc_lasty = y
        let b:apc_tick = b:changedtick
    endif
    return 0
endfunc

" autocmd for CompleteDone
function! s:complete_done()
    let b:apc_lastx = col('.') - 1
    let b:apc_lasty = line('.') - 1
    let b:apc_tick = b:changedtick
endfunc

" enable apc
function! s:apc_enable()
    call s:apc_disable()
    augroup ApcEventGroup
        au!
        au CursorMovedI <buffer> nested call s:feed_popup()
        au CompleteDone <buffer> call s:complete_done()
    augroup END
    let b:apc_init_autocmd = 1
    if g:apc_enable_tab
        inoremap <silent><buffer><expr> <tab>
                    \ pumvisible()? "\<c-n>" :
                    \ <SID>check_back_space() ? "\<tab>" : "\<c-n>"
        inoremap <silent><buffer><expr> <s-tab>
                    \ pumvisible()? "\<c-p>" : "\<s-tab>"
        let b:apc_init_tab = 1
    endif
    if get(g:, 'apc_cr_confirm', 0) == 0
        inoremap <silent><buffer><expr> <cr> 
                    \ pumvisible()? "\<c-y>\<cr>" : "\<cr>"
    else
        inoremap <silent><buffer><expr> <cr> 
                    \ pumvisible()? "\<c-y>" : "\<cr>"
    endif
    inoremap <silent><buffer><expr> <bs> <SID>on_backspace()
    let b:apc_init_bs = 1
    let b:apc_init_cr = 1
    let b:apc_save_infer = &infercase
    setlocal infercase
    let b:apc_enable = 1
endfunc

" disable apc
function! s:apc_disable()
    if get(b:, 'apc_init_autocmd', 0)
        augroup ApcEventGroup
            au! 
        augroup END
    endif
    if get(b:, 'apc_init_tab', 0)
        silent! iunmap <buffer><expr> <tab>
        silent! iunmap <buffer><expr> <s-tab>
    endif
    if get(b:, 'apc_init_bs', 0)
        silent! iunmap <buffer><expr> <bs>
    endif
    if get(b:, 'apc_init_cr', 0)
        silent! iunmap <buffer><expr> <cr>
    endif
    if get(b:, 'apc_save_infer', '') != ''
        let &l:infercase = b:apc_save_infer
    endif
    let b:apc_init_autocmd = 0
    let b:apc_init_tab = 0
    let b:apc_init_bs = 0
    let b:apc_init_cr = 0
    let b:apc_save_infer = ''
    let b:apc_enable = 0
endfunc

" check if need to be enabled
function! s:apc_check_init()
    if &bt != ''
        return
    endif
    if get(g:apc_enable_ft, &ft, 0) != 0
        ApcEnable
    elseif get(g:apc_enable_ft, '*', 0) != 0
        ApcEnable
    elseif get(b:, 'apc_enable', 0)
        ApcEnable
    endif
endfunc

" commands & autocmd
command! -nargs=0 ApcEnable call s:apc_enable()
command! -nargs=0 ApcDisable call s:apc_disable()

augroup ApcInitGroup
    au!
    au FileType * call s:apc_check_init()
    au BufEnter * call s:apc_check_init()
    au TabEnter * call s:apc_check_init()
augroup END

set cpt=.,k,w,b
set completeopt=menu,menuone,noselect
let g:apc_enable_ft = {'text':1, 'verilog':1, '"vim':1}
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"
ApcEnable
