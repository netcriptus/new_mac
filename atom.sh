#!/bin/bash

echo "#### Installing Atom ####"
echo
brew install atom

ATOM_HELPERS='atom-beautify atom-ide-ui atom-spotified busy-signal git-blame highlight-selected language-docker intentions'
PYTHON_PKGS='autocomplete-python linter linter linter-flake8 goto-definition hyperclick python-indent python-isort python-tools'
RUBY_PKGS='cucumber'
ELIXIR_PKGS='language-elixir elixir-block ide-elixir'
MISC_PKGS='sort-lines busy-signal intentions project-sidebar teletype'

which apm >&- && apm install ${ATOM_HELPERS} ${PYTHON_PKGS} ${RUBY_PKGS} ${ELIXIR_PKGS} ${MISC_PKGS}
