# 補完機能
# % brew install zsh-completions
autoload -Uz compinit
compinit -u
if [ -e /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完候補を詰めて表示
setopt list_packed
# 補完候補一覧をカラー表示
autoload colors
zstyle ':completion:*' list-colors ''
# コマンドのスペルを訂正
setopt correct

# プロンプト設定
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
  # 1行あける
  print
  # カレントディレクトリ
  local left='%F{046}[%n@%m]%f: %~'
  # バージョン管理されてた場合、ブランチ名
  vcs_info
  local right="%{\e[38;5;32m%}${vcs_info_msg_0_}%{\e[m%}"
  # スペースの長さを計算
  local invisible='%([BSUbfksu]|([FK]|){*})'
  local leftwidth=${#${(S%%)left//$~invisible/}}
  local rightwidth=${#${(S%%)right//$~invisible/}}
  local padwidth=$(($COLUMNS - ($leftwidth + $rightwidth) % $COLUMNS))

  print -P $left${(r:$padwidth:: :)}$right
}
# ユーザ名@ホスト名
PROMPT='%# '
# 現在時刻
TMOUT=1
TRAPALRM() {
  zle reset-prompt
}

# alias
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias g='git'
alias mem='top -o rsize'
alias cpu='top -o cpu'
