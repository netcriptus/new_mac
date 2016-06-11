#!/bin/bash

brew cask install atom

GO_PKGS='builder-go formatter-gofmt autocomplete-go go-config go-get go-plus gofmt gometalinter-linter gorename navigator-godef tester-go'
PYTHON_PKGS='atom-django autocomplete-python goto-definition linter linter-pep8 python-indent python-iresolve python-isort'

apm install ${GO_PKGS} ${PYTHON_PKGS}
