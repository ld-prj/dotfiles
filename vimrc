" See https://github.com/junegunn/vim-plug for plugin manager install
" vim-plug run :PlugInstall to update q to close
call plug#begin('~/.vim/plugged')

" YouCompleteMe CONFIG {{{
function! BuildYCM(info)

    if a:info.status == 'installed' || a:info.force
        !./install.py --clang-completer
    endif

" FIXME: github issue: throws UltiSnips#SnippetsInCurrentScope(1) error when using the a.vim plugin
" YCM dependent?
Plug 'SirVer/ultisnips'

" YouCompleteMe glob conf
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1

" .ycm_extra_conf.py semantic support file generator
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" YCM default semantic flag file (if no make file)
aug YCM
    au!
    au FileType c      let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_files/c/.ycm_extra_conf.py'
    au FileType cpp    let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_files/cpp/.ycm_extra_conf.py'
aug END

endfunction

" CSE server compatible
Plug 'Valloric/YouCompleteMe', { 'for' : 'v:version == 704' ,'do' : function('BuildYCM') }

" }}}


" VimFiler {{{
" TODO: icons for text files
" FIXME: tree folders for explorer
" TODO: map explorer
" FIXME: get Explorer as default
function! VimfilerSetup()
" TODO: edit
" vimfiler vim on dir opens in explorer mode
call vimfiler#custom#profile('default', 'context', {
            \ 'explorer': 1
            \ })
let g:vimfiler_as_default_explorer = 1

" vimfiler dependent
Plug 'Shougo/unite.vim'

endfunction

Plug 'Shougo/vimfiler.vim', { 'do' : function('VimfilerSetup') }
" }}}


Plug 'Yggdroot/indentLine'
" Usage: indentLine char = '<ASCII char>' || '<¦, ┆, │, ⎸, ▏>'
"let g:indentLine_char = 'c'


Plug 'tpope/vim-commentary' 
" Usage: un/comment lines: gcc=line <vis mode>gc=selection gcgc=blockOfComment


" FIXME: Open on RHS? nav not close window?
Plug 'Dimercel/todo-vim'    " todo navigation
nmap <F5> :TODOToggle<CR>
" Usage: toggle with <F5>

Plug 'vim-scripts/a.vim'    
" Usage: :A=.h/.c of curr file :AV=:A+vert split :IH=file under cursor :IHV=:IH+vert split


Plug 'junegunn/rainbow_parentheses.vim'
" Usage: :RainbowParentheses!!=toggle
" TRY ME: uncomment line below and tyep :R<TAB>!!
"(((((((())))))))

call plug#end()


" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %


" TODO: Add toggle
" Language check for text files
aug langCheck
    au!
    au FileType md,markdown,text 
        \ setlocal spell spelllang=en_au,en_us |
        \ setlocal spellcapcheck=""
aug END


" new found commands
set incsearch   " Highlight while searching
set linebreak   " whole words overflow line
set hlsearch    " Highlight all search results
" Usage: temp off w/ :nohls, toggle w :hls!

" FIXME: Not always working
" stop highlighting of underscores in markdown files
autocmd BufNewFile,BufRead,BufEnter *.md,*.markdown :syntax match markdownIgnore "_"
set cursorline


" Basic settings
set mouse=a
set number
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set smarttab
set autoindent
colo slate


" TODO: map function keys
" TODO: change leader
" NOTE: use leader more :p
" TODO: remap ^V to pastetoggle ^V pastetoggle
" TODO: learn folding stuff
" TODO: status line write good one
" TODO: add more colorschemes with toggle ability -> checkout wsdjeg
