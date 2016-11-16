#!/bin/bash
#-- Script to automate https://help.github.com/articles/why-is-git-always-asking-for-my-password
#-- Based on https://gist.github.com/m14t/3056747
read -p "Are you sure you want to change this repository from https to ssh?  This can be undone, but only if you stop being lazy and write the script to reverse it. Y/N " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  REPO_URL=`git remote -v | grep -m1 '^origin' | sed -Ene's#.*(https://[^[:space:]]*).*#\1#p'`
  if [ -z "$REPO_URL" ]; then
    echo "-- ERROR:  Could not identify Repo url."
    echo "   It is possible this repo is already using SSH instead of HTTPS."
    exit
  fi

  USER=`echo $REPO_URL | sed -Ene's#https://github.com/([^/]*)/(.*).git#\1#p'`
  if [ -z "$USER" ]; then
    echo "-- ERROR:  Could not identify User."
    exit
  fi

  REPO=`echo $REPO_URL | sed -Ene's#https://github.com/([^/]*)/(.*).git#\2#p'`
  if [ -z "$REPO" ]; then
    echo "-- ERROR:  Could not identify Repo."
    exit
  fi

  NEW_URL="git@github.com:$USER/$REPO.git"
  echo "Changing repo url from "
  echo "  '$REPO_URL'"
  echo "      to "
  echo "  '$NEW_URL'"
  echo ""

  CHANGE_CMD="git remote set-url origin $NEW_URL"
  `$CHANGE_CMD`

  echo "Success"
else
  echo "Action cancelled."

fi
