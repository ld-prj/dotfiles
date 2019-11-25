" See https://github.com/junegunn/vim-plug for plugin manager install
call plug#begin('~/.vim/plugged')
" Usage: vim-plug run :PlugInstall to update q to close


" YouCompleteMe CONFIG {{{
" CSE server compatible
if v:version > 703 || (v:version == 703 && has('patch1578'))
    function! BuildYCM(info)
        if a:info.status == 'installed' || a:info.force
            !./install.py --clang-completer
        endif
    endfunction

    Plug 'Valloric/YouCompleteMe', { 'do' : function('BuildYCM') }

    Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
    " Usage: :YcmGenerateConfig or 
    " ~/.vim/plugged/YCM-Generator/config_gen.py ./

    " YouCompleteMe glob conf
    let g:ycm_complete_in_comments = 1
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_autoclose_preview_window_after_insertion = 1
    let g:ycm_open_loclist_on_ycm_diags = 0
    let g:ycm_use_ultisnips_completer = 0
    " Apply YCM FixIt
    " Hacky 'move to bottom window and close'
    map <F9> :YcmCompleter FixIt<CR><C-w>3j:q<CR><C-w>3k

    

    " hacky method of enter button accepting YCM suggestion
    " only when pop-up is visible 
    " https://github.com/Valloric/YouCompleteMe/issues/232#issuecomment-299677328
    " replaced '\<C-Y>' with <SNR>47_StopCompletion( "\<C-Y>" ) to trigger
    "    close of pop up (see :imap for <C-Y> mapping)
    "FIXME: ONLY WORKS FOR CPP FILES :(
    "inoremap <expr> <CR> pumvisible() ? <SNR>47_StopCompletion( "\<C-Y>" ) : "\<CR>"
    "need to figure out modular solution or add to .vim/ftdetect/cpp.vim etc
    "or create autocmd per ft or num. eg .c, .py, .txt have 45 intead of 47
    " TODO: for further investigation read:
    " https://stackoverflow.com/questions/24027506/get-a-vim-scripts-snr
    
    " dis isd d s 
    " YCM default semantic flag file (if no make file)
    " let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_files/.ycm_extra_conf.py'
endif

" }}}


" VimFiler {{{
" TODO: icons for text files
" FIXME: tree folders for explorer
" TODO: map explorer
Plug 'Shougo/vimfiler.vim'

" vimfiler dependent
Plug 'Shougo/unite.vim'

" }}}


Plug 'Yggdroot/indentLine'
" Usage: indentLine char = '<ASCII char>' || '<¦, ┆, │, ⎸, ▏>'
"let g:indentLine_char = 'c'


" FIXME: work multiple comment types '//' and '/**/'
Plug 'tpope/vim-commentary' 
" Usage: un/comment lines: gcc=line <vis mode>gc=selection gcgc=blockOfComment
" :filetype plugin on
autocmd FileType c,cpp setlocal commentstring=//\ %s



" FIXME: Open on RHS? nav not close window?
Plug 'Dimercel/todo-vim'    " todo navigation
nmap <F5> :TODOToggle<CR>
" Usage: toggle with <F5>


Plug 'micbou/a.vim'
" Usage: :A=.h/.c of curr file :AV=:A+vert split :IH=file under cursor :IHV=:IH+vert split


Plug 'junegunn/rainbow_parentheses.vim'
" Usage: :RainbowParentheses!!=toggle
" TRY ME: uncomment line below and tyep :R<TAB>!!
" (((((((())))))))

Plug 'lervag/vimtex'
" let g:tex_flavor='latex'
" Prevent tags being concealed by indentLine
autocmd BufNewFile,BufRead *.tex IndentLinesDisable
autocmd BufNewFile,BufRead *.tex set tw=80
" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" bruvbox colorscheme:
" Plug 'morhetz/gruvbox' % no longer supported
Plug 'gruvbox-community/gruvbox'
let g:gruvbox_guisp_fallback = "bg"

call plug#end()

" TODO: edit - need to wrap in check if loaded
" vimfiler vim on dir opens in explorer mode
call vimfiler#custom#profile('default', 'context', {
            \ 'explorer': 1
            \ })
let g:vimfiler_as_default_explorer = 1


"vnoremap  "+y
" Check if these get rid of anything important
" Remap Ctrl+w in insert mode, able to split screen from insert mode
inoremap <C-w> <ESC><C-w>
" rempap split screen easier
nnoremap <C-w>s <C-w>S
"remap paste
vnoremap <leader>c "+y
noremap <leader>v <ESC>:se paste<CR>"+p:se nopaste<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" close curleys
function! s:CloseBracket()
    let line = getline('.')
    if line =~# '^\s*\(struct\|class\|enum\) '
        return "{\<Enter>};\<Esc>O"
    elseif searchpair('(', '', ')', 'bmn', '', line('.'))
        " Probably inside a function call. Close it off.
        return "{\<Enter>});\<Esc>O"
    else
        return "{\<Enter>}\<Esc>O"
    endif
endfunction


inoremap <expr> {<Enter> <SID>CloseBracket()    


" TODO: Add toggle
" Add ignore for help files
" Language check for text files
" aug langCheck
"     au!
"     au FileType md,markdown,text 
"                 \ setlocal spell spelllang=en_au,en_us |
"                 \ setlocal spellcapcheck=""
" aug END


" new found commands
set incsearch   " Highlight while searching
set linebreak   " whole words overflow line
set hlsearch    " Highlight all search results
" Usage: temp off w/ :nohls, toggle w :hls!
set cursorline


" FIXME: Not always working
autocmd BufNewFile,BufRead,BufEnter *.md,*.markdown :syntax match markdownIgnore "_"

" Basic settings
set mouse=a
set number
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set smarttab
set autoindent
" colo slate
colorscheme gruvbox
set background=dark
"let g:gruvbox_contrast_dark='hard' "medium default

set spelllang=en_au

" TODO: map function keys
" TODO: change leader
" NOTE: use leader more :p
" TODO: remap ^V to pastetoggle ^V pastetoggle
" TODO: learn folding stuff
" TODO: status line write good one
" TODO: add more colorschemes with toggle ability -> checkout wsdjeg
" TODO: Auto indent and close bracket on {}

" TODO: write my own status line
" function! StatusLine()
"     return "my usual statusline"
" endfunction
" aug HELPstatus
"     au!
"     au FileType help setlocal statusline=%!LocalStatusLine()
" aug END
" function! LocalStatusLine()
"     return "%#error#[HELP]%*"
" endfunction
" TODO: learn diff between map, remap, noremap etc
" mouse scroll, scrolls cursor or scrolls no cursur move
" lazy loading
" vim on cse
" why YCM gets so slow?
" set leader short for :se nohls
" 
set foldmethod=indent
set foldlevel=100
"EXPERIMENTATION!!!
" Fold text with extra dash removed, such that number of dashes is foldlevel
function MyFoldText()
    let line = getline(v:foldstart)
    let sub = substitute(line, '^\s*\|//\s*\|/\*\|\*/\|{{{\d\=', '', 'g')
    let oneLessDash = strpart(string(v:folddashes),1,len(string(v:folddashes))-2)
    let foldlinecount = foldclosedend(v:foldstart) - foldclosed(v:foldstart) + 1
    let lineCount = " " . string(foldlinecount) . " lines: "
    return "+" . oneLessDash . lineCount . sub
endfunction
set foldtext=MyFoldText()
" set foldtext='\ '
