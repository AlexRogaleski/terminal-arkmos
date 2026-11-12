# Plugins.
#
# Vêm do Homebrew (Brewfile), e não de git clone fixado em commit: o brew
# cuida de atualização, e nada é baixado na primeira abertura do shell. No
# Arkmos são os RPMs do Fedora, em /usr/share.
#
# Este módulo é o último carregado. O syntax-highlighting embrulha os widgets
# já definidos, então precisa ver keybindings.zsh pronto; o autosuggestions
# lê o histórico, então precisa ver history.zsh pronto.

# Variáveis antes do source: os dois plugins leem a configuração ao carregar.

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
[[ -r $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] \
    && source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
[[ -r $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] \
    && source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
