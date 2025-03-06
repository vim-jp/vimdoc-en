set nocompatible
set nomore
set encoding=utf-8
set fileencodings=utf-8
syntax on
colorscheme delek
let g:html_no_progress = 1

source <sfile>:h/tag_aliases.vim
source <sfile>:h/makehtml.vim

let s:tools_dir = expand('<sfile>:p:h')
let s:proj_dir = expand('<sfile>:p:h:h')

function! s:ToJekyll()
  let helpname = expand('%:t:r')
  if helpname == 'index'
    let helpname = 'help'
  endif
  " remove header
  silent 1,/^<hr>/delete _
  " remove footer
  silent /^<hr>/,$delete _
  " escape jekyll tags
  silent %s/{\{2,}\|{%/{{ "\0" }}/ge
  " YAML front matter
  call append(0, [
        \ '---',
        \ 'layout: vimdoc',
        \ printf("helpname: '%s'", helpname),
        \ '---',
        \ ])
endfunction

" Convert Vim's dodcument in current bufffer to HTML.
function VimdocEnConvert()
  set foldlevel=1000
  " for the lastest help syntax
  let &runtimepath = s:tools_dir . ',' . &runtimepath
  " for ja custom syntax
  let &runtimepath .= ',' . s:proj_dir

  " Avoid problem with highlight group helpIgnore character not being removed
  hi Ignore guifg=#ffffff ctermfg=white

  let dst = expand("%:r") . ".html"

  call MakeHtml3("", 1)

  silent f! `=dst`

  set fileformat=unix
  call s:ToJekyll()
endfunction
