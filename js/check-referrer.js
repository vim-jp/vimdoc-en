$(function() {
  'use strict';
  var REDIRECTS = {
    '//vim-jp.org/vimdoc-ja/ft_rust.html': true,
    '//vim-jp.org/vimdoc-ja/hebrew.html': true,
    '//vim-jp.org/vimdoc-ja/todo.html': true,
    '//vim-jp.org/vimdoc-ja/version5.html': true,
    '//vim-jp.org/vimdoc-ja/version6.html': true,
    '//vim-jp.org/vimdoc-ja/version7.html': true,
  };
  var CLS = 'redirected-by-notranslation';
  var MSG = 'このページには日本語訳が存在しないために英語版に転送されました。';
  if (REDIRECTS[document.referrer.replace(/^https?:/, '')]) {
    $('.header').append('<div class="' + CLS + '">' + MSG + '</div>');
  }
})
