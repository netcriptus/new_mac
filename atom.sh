#!/bin/bash

echo "#### Installing Atom ####"
echo
brew cask install atom

GO_PKGS='gofmt gometalinter-linter navigator-godef'
PYTHON_PKGS='autocomplete-python linter linter-pep8 python-indent python-isort python-tools'
RUBY_PKGS='cucumber'
MISC_PKGS='atom-spotify2 language-docker git-blame sort-lines busy-signal intentions'

which apm >&- && apm install ${GO_PKGS} ${PYTHON_PKGS} ${RUBY_PKGS} ${MISC_PKGS}
