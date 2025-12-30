MAKE_DIR := $(CURDIR)

create-shortcut:
	chmod +x dotfiles.sh
	echo "alias dotfiles='$(MAKE_DIR)/dotfiles.sh'" >> ~/.zshrc
	source ~/.zshrc
	@echo "Alias added."
test:
	sh ./tests/test_no_duplication.sh