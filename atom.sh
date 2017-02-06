#!/bin/bash

echo "#### Installing Atom ####"
echo
brew cask install atom

GO_PKGS='gofmt gometalinter-linter navigator-godef'
PYTHON_PKGS='autocomplete-python linter linter-pep8 python-indent'
RUBY_PKGS='cucumber'
GIT_PKGS='git-blame'

which apm >&- && apm install ${GO_PKGS} ${PYTHON_PKGS}
