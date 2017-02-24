.PHONY: all html clean

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
