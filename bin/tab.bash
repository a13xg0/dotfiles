#!/bin/bash
#
# Open new Terminal tabs from the command line
#
# Author: Justin Hileman (http://justinhileman.com)
#
# Installation:
#     Add the following function to your `.bashrc` or `.bash_profile`,
#     or save it somewhere (e.g. `~/.tab.bash`) and source it in `.bashrc`
#
# Usage:
#     tab                   Opens the current directory in a new tab
#     tab [TITLE] [PATH]            Open PATH in a new tab
#     tab [TITLE] [CMD]             Open a new tab and execute CMD
#     tab [TITLE] [PATH] [CMD] ...  You can prob'ly guess

# Only for teh Mac users
[ `uname -s` != "Darwin" ] && return

function tab () {
    local cmd=""
    local title=$1
    local cdto="$PWD"
    local args="${@:2}"

    if [ -d "$2" ]; then
        cdto=`cd "$2"; pwd`
        args="${@:3}"
    fi

    if [ -n "$args" ]; then
        cmd="; $args"
    fi

    osascript &>/dev/null <<EOF
        tell application "iTerm2"
            tell current window
                create tab with default profile 
                tell current session
                    write text "title \"$title\""
                    write text "cd \"$cdto\"$cmd"
                end tell
            end tell
        end tell
EOF
}
