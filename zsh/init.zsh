# terminal-arkmos — configuração do Zsh.
#
# Os mesmos módulos do Arkmos, adaptados para uma conta no Bazzite: em vez de
# /usr e RPM, vivem neste repositório e as ferramentas vêm do Homebrew.
#
# Carregado pela primeira linha do ~/.zshrc, que continua sendo um arquivo
# comum da conta: o que vem depois dessa linha tem a última palavra, e
# instaladores que escrevem no ~/.zshrc (lerd, nvm...) continuam funcionando.
#
# A ordem dos módulos importa: paths vem primeiro porque os outros perguntam
# '$+commands[...]' e o completion precisa do fpath pronto; os plugins vêm no
# fim porque o syntax-highlighting embrulha os widgets já definidos e o
# autosuggestions se apoia no histórico já configurado.

# Diretório real deste arquivo, sem hardcode: %x é o script em execução, :A
# resolve links e :h corta o nome do arquivo.
ARKMOS_ZSH="${${(%):-%x}:A:h}"

for _module in paths history completion keybindings aliases tools plugins; do
    [[ -r "$ARKMOS_ZSH/$_module.zsh" ]] && source "$ARKMOS_ZSH/$_module.zsh"
done
unset _module
