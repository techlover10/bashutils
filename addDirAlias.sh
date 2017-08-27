#!/usr/bin/env bash
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
  echo "To add an alias to your bashrc, run this script as root."
  exit
fi

if [[ $# -eq 0 ]]
then
  echo "Alias name required for alias"
  exit
fi
dir=$(printf "%q\n" "$(pwd)")
echo "Are you sure you want to add the following alias to your bashrc? Y/N"
read -p "alias $1='cd $dir' " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "alias $1='cd $dir'" >> ~/.bash_aliases
  echo "Alias added: $1"
  eval 'source ~/.bashrc'
else
  echo "Action cancelled."
fi
