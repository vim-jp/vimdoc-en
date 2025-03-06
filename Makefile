.PHONY: all html clean

VIM_ALL_TEXT = $(wildcard vim/runtime/doc/*.txt)
SRC_TEXT = $(VIM_ALL_TEXT:vim/runtime/doc/%=target/html/doc/%) \
	target/html/doc/tags.txt \
	target/html/doc/vim_faq.txt
DST_HTML = $(SRC_TEXT:%.txt=%.html)

html: vim vim_faq
	$(MAKE) html-generate

html-generate: $(DST_HTML)

vim:
	git clone --depth=1 https://github.com/vim/vim.git
	cd vim && git apply ../tools/add-vimfaq-link.diff

vim/runtime/doc/%.txt: vim

vim_faq:
	git clone --depth=1 https://github.com/chrisbra/vim_faq.git

vim_faq/doc/vim_faq.txt: vim_faq

target/html/doc:
	mkdir -p $@

target/html/doc/tags target/html/doc/tags.txt: $(SRC_TEXT)
	-cd target/html/doc && vim -esu ../../../tools/build_tag.vim -c "qall!"

target/html/doc/%.txt: vim/runtime/doc/%.txt target/html/doc
	cp $< $@

target/html/doc/vim_faq.txt: vim_faq/doc/vim_faq.txt target/html/doc
	cp $< $@

# referenced by $(DST_HTML)
target/html/doc/%.html: target/html/doc/%.txt target/html/doc/tags
	-cd target/html/doc && vim -esu ../../../tools/build_html.vim -c "call VimdocEnConvert() | wqall!" $(<F)

clean:
	rm -rf target

distclean:
	rm -rf vim vim_faq

JEKYLL_WORKDIR=target/jekyll-work
JEKYLL_OUTDIR=target/_site

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
