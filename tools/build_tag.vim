set nocompatible
set nomore
set encoding=utf-8
set fileencodings=utf-8

try
  helptags .
catch
  echo v:exception
endtry

source <sfile>:h/makehtml.vim

call MakeTagsFile()
