# vimdoc-en

This project provides an HTML version of the Vim help pages at <https://vim-jp.org/vimdoc-en/>.

There is already another similar site: <https://vimhelp.org/>.
The main purpose of the vimdoc-en project is to provide a handy way to see both Japanese and English versions of the help pages.

The help pages are automatically updated everyday (if there are any changes).

## for Developers

First of all, to generate everything, just run `make`.
This requires Docker, so prepare it in advance.

Here's what's happening:

1. Run `make html` to generate HTML files before GitHub Pages (Jekyll) processing
    1. Download vim and vim\_faq
    2. Collect the necessary \*.txt files
    3. Convert the \*.txt files to \*.html
2. Run `make jekyll-build-by-docker` to output all HTML files for the vimdoc-en site using GitHub Pages (Jekyll)
