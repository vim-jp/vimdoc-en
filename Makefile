.PHONY: all html clean

JEKYLL_WORKDIR=target/jekyll-work
JEKYLL_OUTDIR=target/_site

all:

html:
	rm -rf target/html
	mkdir -p target/html/doc
	if [ ! -d vim/runtime/doc ]; then git clone --depth=1 https://github.com/vim/vim.git; fi
	if [ ! -d vim_faq/doc ]; then git clone --depth=1 https://github.com/chrisbra/vim_faq.git; fi
	cd vim; git apply ../tools/add-vimfaq-link.diff; cd ..
	cp vim/runtime/doc/*.txt vim_faq/doc/*.txt target/html/doc
	-cd target/html/doc ; vim -eu ../../../tools/buildhtml.vim -c "qall!"

clean:
	rm -rf target

jekyll-build:
	mkdir -p $(JEKYLL_WORKDIR)
	cp target/html/doc/*.html $(JEKYLL_WORKDIR)
	cp -Ru src/* $(JEKYLL_WORKDIR)
	jekyll build -s $(JEKYLL_WORKDIR) -d $(JEKYLL_OUTDIR)

jekyll-clean:
	rm -rf $(JEKYLL_WORKDIR) $(JEKYLL_OUTDIR)

.PHONY: jekyll-build jekyll-clean
