#!/bin/bash

echo "#### Installing Atom ####"
echo
brew cask install atom

GO_PKGS='formatter-gofmt autocomplete-go go-get gofmt gometalinter-linter navigator-godef'
PYTHON_PKGS='atom-django autocomplete-python goto-definition linter linter-pep8 python-indent python-iresolve python-isort'

which apm >&- && apm install ${GO_PKGS} ${PYTHON_PKGS}
