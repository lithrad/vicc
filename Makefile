# wget https://raw.github.com/lithrad/vicc/master/Makefile -O - | make -- install

master=git://github.com/lithrad/vicc.git
dest=$(HOME)/.vim/bundle/vicc
vimrc=$(HOME)/.vimrc

all: install
install: download vim

download:
	mkdir -p $(dest)
	git clone $(master) --depth=1 $(dest)

vim:
	@echo "let g:cc_plug_custom = []" >> $(vimrc)
	@echo "let \$$PLUG_DIR = expand('\$$HOME/.vim/bundle')" >> $(vimrc)
	@echo "source \$$PLUG_DIR/vicc/plugin/vicc.vim" >> $(vimrc)
	@vim +PlugInstall +qall
