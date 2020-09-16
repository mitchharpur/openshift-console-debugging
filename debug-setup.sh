#!/usr/bin/env bash
reset=$(tput sgr0)
bold=$(tput bold)

red=$(tput setaf 1)                     # bright red text
green=$(tput setaf 2)
darkcyan=$(tput setaf 6)                # dim cyan text
cyan=$bold$darkcyan                     # bright cyan text
gray=$(tput setaf 7)                    # dim white text
darkgray=$bold$(tput setaf 0)           # bold black = dark gray text
white=$bold$gray                        # bright white text
yellow=$(tput setaf 3)                  # dark yellow text

echo -e "$yellow$bold Installing required VSCode extensions ... $reset"
. ./debug-install-plugins.sh
echo -e "$yellow$bold Checking and setting up console debugging environment  ... $reset"
. ./debug-environment.sh