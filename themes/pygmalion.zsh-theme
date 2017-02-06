# Yay! High voltage and arrows!

prompt_setup_pygmalion(){
  ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}Ξ%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_CLEAN=""

  if [[ "$(whoami)" == "$DEFAULT_USERNAME" ]]
  then
    username="me"
  else
    username="%n"
  fi

  if [[ "$(hostname)" == "$DEFAULT_HOSTNAME" ]]
  then
    hostname="home"
  else
    hostname="%m"
  fi

  base_prompt='%{$fg_bold[red]%}$username%{$reset_color%}%{$fg_bold[cyan]%}@%{$reset_color%}%{$fg_bold[green]%}$hostname%{$reset_color%}%{$fg[red]%}:%{$reset_color%}%{$fg[blue]%}%0~%{$reset_color%}'
  post_prompt='%{$fg_bold[blue]%}»%{$reset_color%} '

  base_prompt_nocolor=$(echo "$base_prompt" | perl -pe "s/%\{[^}]+\}//g")
  post_prompt_nocolor=$(echo "$post_prompt" | perl -pe "s/%\{[^}]+\}//g")

  precmd_functions+=(prompt_pygmalion_precmd)
}

prompt_pygmalion_precmd(){
  local gitinfo=$(git_prompt_info)
  local gitinfo_nocolor=$(echo "$gitinfo" | perl -pe "s/%\{[^}]+\}//g")
  local exp_nocolor="$(print -P \"$base_prompt_nocolor$gitinfo_nocolor$post_prompt_nocolor\")"
  local prompt_length=${#exp_nocolor}

  local nl=""

  if [[ $prompt_length -gt 40 ]]; then
    nl=$'\n%{\r%}';
  fi

  local pipe=""
  if [ $gitinfo ]; then
    pipe="%{$fg[red]%}|%{$reset_color%}"
  fi

  PROMPT="$base_prompt$pipe$gitinfo $nl$post_prompt"
}

prompt_setup_pygmalion
