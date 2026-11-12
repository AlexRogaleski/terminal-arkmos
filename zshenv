# terminal-arkmos — aponta o zsh para ~/.config/zsh.
#
# ~/.zshenv é um link para este arquivo. É o primeiro arquivo da conta que o
# zsh lê, e por isso o único de onde dá para mudar o ZDOTDIR: no Arkmos isso
# fica em /etc/zshenv, aqui fica na conta para não mexer no sistema.
#
# Um ZDOTDIR já definido no ambiente vence sempre.

if [ -z "${ZDOTDIR:-}" ] || [ "$ZDOTDIR" = "$HOME" ]; then
    export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
fi
