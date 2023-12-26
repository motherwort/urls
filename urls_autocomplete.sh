#!/bin/bash

_SCRIPT_LOCATION=~/projects/urls/urls.sh

_get_urls_scopes(){
  for match in "$(cat $URLS_FILE | grep -o "^[^=]*")"; do
    scopes="${scopes:+$scopes }$match"
  done
  echo $scopes
}

_urls_autocomplete()
{
  _script_commands=$($_SCRIPT_LOCATION _options)

  local cur
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  if [[ "$COMP_CWORD" == 1 ]]; then
    COMPREPLY=( $(compgen -W "${_script_commands}" -- ${cur}) )
  elif [[
    "$COMP_CWORD" == 2
    && "${COMP_WORDS[COMP_CWORD - 1]}" != "add"
    && "${COMP_WORDS[COMP_CWORD - 1]}" != "ignore"
  ]]; then
    COMPREPLY=( $(compgen -W "admin api django" -- ${cur}) )
  fi

  return 0
}

complete -F _urls_autocomplete "$_SCRIPT_LOCATION"
