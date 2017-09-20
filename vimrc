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
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_autoclose_preview_window_after_completion = 1


    " YCM default semantic flag file (if no make file)
    " let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_files/.ycm_extra_conf.py'
endif

" FIXME: github issue: throws UltiSnips#SnippetsInCurrentScope(1) error when using the a.vim plugin
" YCM dependent?
"Plug 'SirVer/ultisnips'

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


" TODO: edit
" vimfiler vim on dir opens in explorer mode
call vimfiler#custom#profile('default', 'context', {
            \ 'explorer': 1
            \ })
let g:vimfiler_as_default_explorer = 1


" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %


" TODO: Add toggle
" Add ignore for help files
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
