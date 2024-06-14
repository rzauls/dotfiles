.PHONY: stow delete

stow: 
	@stow --verbose --target=${HOME} --restow */

delete:
	@stow --verbose --target=${HOME} --delete */
