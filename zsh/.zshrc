# terminal-arkmos — configuração do Zsh.
#
# Os mesmos módulos do Arkmos, adaptados para uma conta no Bazzite: em vez de
# /usr e RPM, vivem neste repositório e as ferramentas vêm do Homebrew.
#
# ~/.config/zsh/.zshrc é um link para este arquivo, e o ZDOTDIR que aponta
# para lá é definido em ~/.zshenv (o zshenv deste repositório).
#
# Ajustes desta máquina vão em ~/.config/zsh/local.zsh, que não é versionado
# e é carregado por último, com a última palavra sobre tudo o que vem abaixo.
#
# A ordem dos módulos importa: paths vem primeiro porque os outros perguntam
# '$+commands[...]' e o completion precisa do fpath pronto; os plugins vêm no
# fim porque o syntax-highlighting embrulha os widgets já definidos e o
# autosuggestions se apoia no histórico já configurado.

# Diretório real deste arquivo, sem hardcode: %x é o script em execução, :A
# resolve o link de ~/.config/zsh e :h corta o nome do arquivo.
ARKMOS_ZSH="${${(%):-%x}:A:h}"

for _module in paths history completion keybindings aliases tools plugins; do
    [[ -r "$ARKMOS_ZSH/$_module.zsh" ]] && source "$ARKMOS_ZSH/$_module.zsh"
done
unset _module

_arkmos_local="${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}/local.zsh"
[[ -r "$_arkmos_local" ]] && source "$_arkmos_local"
unset _arkmos_local
