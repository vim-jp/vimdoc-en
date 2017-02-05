.PHONY: all html clean

all:

html:
	rm -rf target/html
	mkdir -p target/html/doc
	if [ ! -d vim/runtime/doc ]; then git clone --depth=1 https://github.com/vim/vim.git; fi
	cp vim/runtime/doc/*.txt target/html/doc
	cp tools/buildhtml.vim tools/makehtml.vim target/html
	-cd target/html/doc ; vim -eu ../buildhtml.vim -c "qall!"

clean:
	rm -rf target
