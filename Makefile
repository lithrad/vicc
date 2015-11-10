# wget https://raw.github.com/lithrad/vimcc/master/Makefile -O - | make -- install

master=git://github.com/lithrad/vimcc.git
dest=$(HOME)/.vim/bundle/vimcc
vimrc=$(HOME)/.vimrc

all: install
install: download vim

download:
	mkdir -p $(dest)
	git clone $(master) --depth=1 $(dest)

vim:
	@echo "let g:my_plugs = []" >> $(vimrc)
	@echo "let \$$PLUG_DIR = expand('\$$HOME/.vim/bundle')" >> $(vimrc)
	@echo "source \$$PLUG_DIR/vimcc/plugin/vimcc.vim" >> $(vimrc)
	@vim +PlugInstall +qall
