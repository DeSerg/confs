#!/bin/sh


init () {
    source "./.bashrc"

    mkdir -p "$XDG_DATA_HOME"
    # Initialize a few things
    echo 'Initing...'
}

link () {
    echo "This utility will symlink the files in this repo to the home directory"
    echo "Proceed? (y/n)"
    read resp
    # TODO - regex here?
    if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
        for file in $( ls -A | grep -vE '\.exclude*|\.git$|\.gitignore|.*.md' ) ; do
            ln -sv "$PWD/$file" "$HOME"
        done
        # TODO: source files here?
        echo "Symlinking complete"
    else
        echo "Symlinking cancelled by user"
        return 1
    fi
}

install_tools () {
    osType="$(uname -s)"
    if [ "$osType" = "Linux" ] ; then
        echo "This utility will install useful utilities using apt"
        echo "Proceed? (y/n)"
        read resp
        # TODO - regex here?
        if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
            echo "Installing useful stuff using apt. This may take a while..."
            sh apt.exclude.sh
        else
            echo "Apt installation cancelled by user"
        fi
    elif [ "$osType" = "Darwin" ] ; then
        echo "This utility will install useful utilities using Homebrew"
        echo "Proceed? (y/n)"
        read resp
        if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
            echo "Installing useful stuff using brew. This may take a while..."
            sh brew.exclude.sh
        else
            echo "Brew installation cancelled by user"
        fi
    else
        echo "Skipping installations because neither Homebrew nor Linux were detected..."
    fi
}

init
link
install_tools
