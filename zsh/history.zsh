# Histórico.
#
# Fica no diretório de estado do usuário, como no Arkmos: histórico é dado de
# quem usa, e não configuração versionada.

HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
HISTSIZE=50000
SAVEHIST=50000

# O zsh não cria o diretório do HISTFILE. Sem ele, simplesmente não grava —
# e falha em silêncio, o que rende a impressão de que o histórico "não
# funciona" sem nenhuma mensagem de erro.
#
# O teste em $HOME evita um 'mkdir' com erro em ambiente sem home, como um
# container de verificação.
if [[ -d "$HOME" && ! -d "${HISTFILE:h}" ]]; then
    mkdir -p "${HISTFILE:h}"
fi

setopt APPEND_HISTORY        # acrescenta ao arquivo em vez de sobrescrever
setopt INC_APPEND_HISTORY    # grava a cada comando, não só ao sair
setopt SHARE_HISTORY         # terminais abertos veem o histórico um do outro
setopt HIST_IGNORE_ALL_DUPS  # uma entrada por comando, a mais recente
setopt HIST_IGNORE_SPACE     # comando iniciado com espaço não entra
setopt HIST_REDUCE_BLANKS    # normaliza espaçamento antes de guardar
setopt HIST_VERIFY           # expansão com ! é mostrada antes de executar
setopt EXTENDED_HISTORY      # guarda horário e duração de cada comando
