#!/usr/bin/env bash
# terminal-arkmos — instala o terminal do Arkmos numa conta do Bazzite.
#
# Pode rodar quantas vezes quiser: o que já está no lugar fica como está, e
# qualquer arquivo que seria substituído vai antes para uma pasta de backup.
#
#   ./install.sh            instala tudo
#   ./install.sh --no-brew  pula o 'brew bundle' (sem rede, ou já instalado)

set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STATE="${XDG_STATE_HOME:-$HOME/.local/state}"
DATA="${XDG_DATA_HOME:-$HOME/.local/share}"
BACKUP="$STATE/terminal-arkmos/backup-$(date +%Y%m%d-%H%M%S)"

with_brew=1
for arg in "$@"; do
    case "$arg" in
        --no-brew) with_brew=0 ;;
        -h | --help)
            sed -n '2,8p' "$0" | sed 's/^# \{0,1\}//'
            exit 0
            ;;
        *)
            echo "opção desconhecida: $arg" >&2
            exit 2
            ;;
    esac
done

step() { printf '\n\033[1;35m==>\033[0m %s\n' "$*"; }
info() { printf '    %s\n' "$*"; }

# Move para o backup, preservando o caminho relativo ao $HOME.
backup() {
    local file="$1" dest
    dest="$BACKUP/${file#"$HOME"/}"
    mkdir -p "$(dirname "$dest")"
    mv "$file" "$dest"
    info "backup: ${file/#$HOME/\~} -> ${dest/#$HOME/\~}"
}

# --- Pacotes ---------------------------------------------------------------

if [ "$with_brew" = 1 ]; then
    step "Pacotes do Brewfile"
    if ! command -v brew >/dev/null 2>&1; then
        echo "brew não encontrado. No Bazzite ele vem instalado; veja 'ujust --choose'." >&2
        exit 1
    fi
    brew bundle --file="$REPO/Brewfile"
fi

for tool in zsh fzf; do
    command -v "$tool" >/dev/null 2>&1 || {
        echo "falta o $tool, que o Bazzite deveria trazer em /usr/bin" >&2
        exit 1
    }
done

# --- Zsh -------------------------------------------------------------------

step "Zsh"
# O ~/.zshrc é um arquivo comum, e não um link: a primeira linha carrega o
# zsh/init.zsh daqui, e o resto é da máquina — inclusive o que instaladores
# como o lerd acrescentam. Um ~/.zshrc que já carrega o init.zsh fica como
# está; qualquer outro vai para o backup e dá lugar ao zsh/zshrc.example.
init="$REPO/zsh/init.zsh"

# A linha usa $HOME no lugar do caminho absoluto, para continuar valendo se o
# repositório estiver no mesmo lugar em outra conta. No Bazzite o /home é um
# link para /var/home, então o caminho do repositório pode vir em qualquer das
# duas formas.
init_line="$init"
for home in "$HOME" "$(realpath "$HOME")"; do
    case "$init" in
        "$home"/*) init_line="\$HOME/${init#"$home"/}" ;;
    esac
done

if [ -f "$HOME/.zshrc" ] && grep -qF -e "$init" -e "$init_line" "$HOME/.zshrc"; then
    info "ok: ~/.zshrc (mantido como está)"
else
    if [ -e "$HOME/.zshrc" ] || [ -L "$HOME/.zshrc" ]; then
        backup "$HOME/.zshrc"
    fi
    sed "s|@INIT@|$init_line|" "$REPO/zsh/zshrc.example" >"$HOME/.zshrc"
    info "criado: ~/.zshrc"
fi

# O histórico do zsh antigo vira o ponto de partida do novo, uma vez só.
hist="$STATE/zsh/history"
if [ ! -e "$hist" ] && [ -s "$HOME/.histfile" ]; then
    mkdir -p "$(dirname "$hist")"
    cp "$HOME/.histfile" "$hist"
    info "histórico: ~/.histfile copiado para ${hist/#$HOME/\~}"
fi

# O compinit -C só refaz o cache quando muda o número de arquivos no fpath.
# Apagar garante que as completions do brew recém-instaladas apareçam.
rm -f "${XDG_CACHE_HOME:-$HOME/.cache}"/zsh/zcompdump-*

# --- Konsole ---------------------------------------------------------------

step "Konsole"
# Cópia, e não link: o Konsole reescreve o perfil quando ele é editado pela
# interface, e trocaria o link por um arquivo comum sem avisar.
install -Dm644 "$REPO/konsole/TokyoNight.colorscheme" "$DATA/konsole/TokyoNight.colorscheme"
install -Dm644 "$REPO/konsole/Arkmos.profile" "$DATA/konsole/Arkmos.profile"
info "tema e perfil em ${DATA/#$HOME/\~}/konsole"

if command -v kwriteconfig6 >/dev/null 2>&1; then
    kwriteconfig6 --file konsolerc --group "Desktop Entry" --key DefaultProfile Arkmos.profile
    info "perfil padrão: Arkmos"
fi

# --- Verificação -----------------------------------------------------------

step "Verificação"
# Um shell interativo novo, do zero, como o Konsole abriria — dentro de um
# pseudo-terminal pelo 'script', porque sem terminal o próprio fzf reclama de
# "can't change option: zle", o que não acontece de verdade. Qualquer coisa
# em stderr é erro de algum módulo.
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

# Aspas simples de propósito: as variáveis são do zsh lá dentro, não deste bash.
# shellcheck disable=SC2016
probe='print -r -- "starship=$STARSHIP_CONFIG"
print -r -- "editor=$EDITOR"
(( $+functions[_zsh_autosuggest_start] )) && print autosuggestions=ok
(( $+ZSH_HIGHLIGHT_VERSION )) && print syntax-highlighting=ok
(( $+functions[fzf-history-widget] )) && print fzf=ok
(( $+functions[__zoxide_z] )) && print zoxide=ok
true'
printf '%s\n' "$probe" >"$tmp/probe.zsh"

script -qec "env -u STARSHIP_CONFIG zsh -i '$tmp/probe.zsh' >'$tmp/out' 2>'$tmp/err'" /dev/null >/dev/null

if [ -s "$tmp/err" ]; then
    echo "o zsh abriu com erros:" >&2
    cat "$tmp/err" >&2
    exit 1
fi
# Só as linhas da sonda: o banner do Bazzite (ujust toggle-user-motd) também
# sai no stdout de um shell interativo.
grep -E '^[A-Za-z-]+=' "$tmp/out" | while IFS= read -r line; do info "$line"; done
for want in autosuggestions syntax-highlighting fzf zoxide; do
    grep -q "^$want=ok" "$tmp/out" || {
        echo "faltou carregar: $want" >&2
        exit 1
    }
done

step "Pronto"
info "Abra um Konsole novo para ver o resultado."
[ -d "$BACKUP" ] && info "Os arquivos antigos estão em ${BACKUP/#$HOME/\~}"
exit 0
