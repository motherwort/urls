#!/bin/bash

FILENAME=.urls

findup () {
    path=$(pwd)
    while [[ "$path" != "" && ! -e "$path/$1" ]]; do
        path=${path%/*}
    done
    
    if [[ ! -z $path ]]; then
        echo "$path/$1"
    else
        echo $FILENAME
    fi
}

openit(){
    echo $1
    open $1
}

dispatch(){
    if [[ -z "$2" ]]; then
        openit "https://$1";
        exit;
    else
        case "$2" in
            "adm" )
                openit "https://admin.$1";;
            "admin" )
                openit "https://admin.$1";;
            "api" )
                openit "https://api.$1/docs";;
            "django" )
                openit "https://api.$1/admin";;
            "dj" )
                openit "https://api.$1/admin";;
            * ) 
                echo "Unknown argument. Use 'admin' ('adm'), 'api' or 'django' ('dj')";;
        esac
    fi
}

FILE=$(findup $FILENAME)

if [[ "$1" == "add" ]]; then
    touch -a $FILE;
    for i in "${@:2}"
        do
        echo "$i" >> $FILE
    done
    exit
fi

if [[ "$1" == "ignore" ]]; then
    if [ -d "./.git/" ]; then
        echo "$FILE" >> ./.git/info/exclude;
        touch -a $FILE;
    else
        echo "Not in a git directory. Did nothing"
    fi
    exit
fi

if [[ "$1" == "_options" ]]; then
    if [ -f "$FILE" ]; then
        for match in "$(cat $FILE | grep -o "^[^=]*")"; do
            scopes="${scopes:+$scopes }$match"
        done
    fi
    commands="add" # do not add `ignore` to the list of commands since it's not documented
    echo "$commands $scopes"
    exit
fi


if [ -f "$FILE" ]; then
    source $FILE;
else
    echo "$FILE file not found";
    exit;
fi

if [[ -z "$1" ]]; then
    cat $FILE;
    exit;
else
    value="${!1}"
    if [[ ! -z $value ]]; then
        dispatch $value $2;
    else
        if [[ -z $(cat $FILE) ]]; then
            echo ".urls is empty"
            echo "add scopes in .urls file";
        else
            echo "available scopes:";
            cat $FILE;
        fi
    fi
fi
