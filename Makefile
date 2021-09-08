TEXINPUTS=LatexPackages//:

### Compilation of the document

full: 
	@TEXINPUTS=${TEXINPUTS} latexmk -pdf -dvi- full.tex

	@TEXINPUTS=${TEXINPUTS} latexmk -pdf -dvi master.tex

# Runs pdflatex on the full document
full-pdflatex: 
	@TEXINPUTS=${TEXINPUTS} pdflatex full.tex


# Initializes the submodule, i.e. clones it correctly
init-submodule:
	@echo "[Make] Initialising submodules..."
	@git submodule update --init --rebase

# Sets up git hooks for gitinfo2 package
init-git-hooks:
	@echo "[Make] Setting up git hooks for package gitinfo2"
	@cp .travis/git-info-2.sh .git/hooks/post-merge
	@cp .travis/git-info-2.sh .git/hooks/post-checkout
	@cp .travis/git-info-2.sh .git/hooks/post-commit
	@.travis/git-info-2.sh

# Initializes submodule and git hooks for this repository
init: init-git-hooks init-submodule

# Sets appropriate git configuration for this repository
config:
	@echo "[Make config] Setting git configs to prevent wrong pushes"
	@git config push.recurseSubmodules check
	@git config status.submodulesummary 1
	@echo "[Push annotated tags by default]"
	@git config push.followTags true

# See
# https://stackoverflow.com/a/26339924/16371376
# for explanation
# Lists all targets in this makefile
.PHONY: list
list:
	@LC_ALL=C $(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'
