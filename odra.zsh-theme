#use extended color palette if available
if [[ $TERM = (*256color|*rxvt*) ]]; then
  red="%{${(%):-"%F{196}"}%}"
  orange="%{${(%):-"%F{172}"}%}"
  blue="%{${(%):-"%F{045}"}%}"
  yellow="%{${(%):-"%F{220}"}%}"
  darkBlue="%{${(%):-"%F{033}"}%}"
else
  red="%{${(%):-"%F{red}"}%}"
  orange="%{${(%):-"%F{yellow}"}%}"
  blue="%{${(%):-"%F{cyan}"}%}"
  yellow="%{${(%):-"%F{yellow}"}%}"
  darkBlue="%{${(%):-"%F{blue}"}%}"
fi

local return_status="%(?:%{$fg_bold[green]%}●:%{$red%}●)"

local prompt_suffix="%{$darkBlue%}❯%{$reset_color%} "

function get_pwd(){
  git_root=$PWD
  while [[ $git_root != / && ! -e $git_root/.git ]]; do
    git_root=$git_root:h
  done
  if [[ $git_root = / ]]; then
    unset git_root
    prompt_short_dir=%~
  else
    parent=${git_root%\/*}
    prompt_short_dir=${PWD#$parent/}
    prompt_short_dir="${prompt_short_dir} %{$yellow%}|%{$reset_color%}"
  fi
  echo $prompt_short_dir
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$blue%}*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='${red}%n%{$reset_color%} ${return_status} %{$orange%}$(get_pwd)%{$reset_color%} $(git_prompt_info)${prompt_suffix}'