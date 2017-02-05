#! /bin/bash
#
# autocommit.sh
# Copyright (C) 2017 jared <jared@jared-devstation>
#
# Distributed under terms of the MIT license.
#

if [[ $1 == "force" ]]
then 
    echo "================================================================================="
    echo "============================== FORCE AUTOCOMMIT ================================="
    echo "================================================================================="
    echo "===============WARNING: YOU ARE AUTOCOMMITTING IN FORCE MODE.===================="
    echo "Please review the untracked files to ensure that nothing undesired will be added."
    echo "================================================================================="
    echo "================================ Git Status ====================================="
    git status
    echo "================================================================================="
    read -p "Are you sure you want to [!!!FORCE!!!] Autocommit? Y/N
" -n 1 -r
else
    read -p "Are you sure you want to Autocommit? Y/N
" -n 1 -r
fi
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    if [[ $1 == "force" ]]
    then
        git add .
    else 
        git add -u
    fi
    git pull origin master
    git commit -m "update"
    git push origin master
else
    echo "Action cancelled."
fi

