.PHONY: all html clean

JEKYLL_WORKDIR=target/jekyll-work
JEKYLL_OUTDIR=target/_site

html-prepare: vim/runtime/doc vim_faq/doc target/html/doc
	rm -f target/html/doc/*.txt
	cp vim/runtime/doc/*.txt target/html/doc
	cp vim_faq/doc/*.txt target/html/doc

html: html-prepare
	-cd target/html/doc ; vim -eu ../../../tools/buildhtml.vim -c "qall!"

vim/runtime/doc:
	git clone --depth=1 https://github.com/vim/vim.git
	cd vim && git apply ../tools/add-vimfaq-link.diff

vim_faq/doc:
	git clone --depth=1 https://github.com/chrisbra/vim_faq.git

target/html/doc:
	mkdir -p $@

clean:
	rm -rf target

distclean:
	rm -rf vim vim_faq

jekyll-build-prepare:
	mkdir -p $(JEKYLL_WORKDIR)
	cp target/html/doc/*.html $(JEKYLL_WORKDIR)
	cp -Ru src/* $(JEKYLL_WORKDIR)

jekyll-build: jekyll-build-prepare
	jekyll build -s $(JEKYLL_WORKDIR) -d $(JEKYLL_OUTDIR)

jekyll-build-by-docker: jekyll-build-prepare
	./tools/docker_jekyll jekyll build -s $(JEKYLL_WORKDIR) -d $(JEKYLL_OUTDIR)

jekyll-clean:
	rm -rf $(JEKYLL_WORKDIR) $(JEKYLL_OUTDIR)

.PHONY: jekyll-build-prepare jekyll-build jekyll-build-by-docker jekyll-clean
