# PATH e fpath.
#
# Não existe no Arkmos, onde tudo está em /usr/bin. Aqui as ferramentas vêm
# do Homebrew e de instaladores na conta, e precisam estar no PATH antes de os
# outros módulos perguntarem '$+commands[...]'.
#
# Cada entrada só entra se o diretório existir: a mesma configuração serve
# numa máquina que não tenha um deles.

# Bibliotecas do Flatpak vazando para o terminal integrado do Zed quebram os
# binários do host.
unset LD_LIBRARY_PATH

# O /etc/profile.d/brew.sh do Bazzite já define isso; o fallback cobre um
# shell aberto sem passar por ele.
: "${HOMEBREW_PREFIX:=/home/linuxbrew/.linuxbrew}"
export HOMEBREW_PREFIX

# 'typeset -U' remove duplicatas e mantém a primeira ocorrência, então
# reabrir um shell dentro de outro não faz o PATH crescer.
typeset -U path fpath

for _dir in \
    "$HOME/.local/share/lerd/bin" \
    "$HOME/.local/bin"; do
    [[ -d "$_dir" ]] && path=("$_dir" $path)
done

# Completions: as dos pacotes do brew (gh, eza, bat, mise...), o pacote
# zsh-completions e as instaladas na conta (lerd).
for _dir in \
    "$HOMEBREW_PREFIX/share/zsh-completions" \
    "$HOMEBREW_PREFIX/share/zsh/site-functions" \
    "$HOME/.local/share/zsh/site-functions"; do
    [[ -d "$_dir" ]] && fpath=("$_dir" $fpath)
done
unset _dir
