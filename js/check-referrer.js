$(function() {
  'use strict';
  var REDIRECTS = {
    'http://vim-jp.org/vimdoc-ja/hebrew.html': true,
    'http://vim-jp.org/vimdoc-ja/todo.html': true,
    'http://vim-jp.org/vimdoc-ja/version5.html': true,
    'http://vim-jp.org/vimdoc-ja/version6.html': true,
    'http://vim-jp.org/vimdoc-ja/version7.html': true,
    'http://vim-jp.org/vimdoc-ja/version8.html': true,
  };
  var CLS = 'redirected-by-notranslation';
  var MSG = 'このページには日本語訳が存在しないために英語版に転送されました。';
  if (REDIRECTS[document.referrer]) {
    $('.header').append('<div class="' + CLS + '">' + MSG + '</div>');
  }
})
