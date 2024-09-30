#!/bin/bash

# install brew if needed
if [ ! -f /home/linuxbrew/.linuxbrew/bin/brew ];
then
  NONINTERACTIVE=1 $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
fi
