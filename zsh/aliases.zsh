# Atalhos.
#
# Cada bloco é guardado por '$+commands[...]': a configuração precisa
# continuar carregando limpa numa máquina onde algum desses pacotes falte.

# --- Listagem --------------------------------------------------------------

if (( $+commands[eza] )); then
    alias ls='eza --group-directories-first --icons=auto'
    alias ll='eza -l  --group-directories-first --icons=auto --git'
    alias la='eza -la --group-directories-first --icons=auto --git'
    alias lt='eza --tree --level=2 --icons=auto'
fi

# 'cat' NÃO é substituído de propósito: pipes e scripts contam com a saída
# exata dele. O bat fica disponível pelo próprio nome, e 'batp' para paginar.
(( $+commands[bat] )) && alias batp='bat --paging=always'

# --- Git -------------------------------------------------------------------

alias g='git'
alias gs='git status --short --branch'
alias ga='git add'
alias gc='git commit'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate -20'
alias gp='git push'
alias gpl='git pull'
alias gco='git checkout'
alias gb='git branch'
(( $+commands[lazygit] )) && alias lg='lazygit'

# --- Containers ------------------------------------------------------------

alias d='docker'
alias dc='docker compose'
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
(( $+commands[lazydocker] )) && alias lzd='lazydocker'

# --- Laravel ---------------------------------------------------------------

# O alias da documentação oficial do Sail: usa o script da raiz do projeto se
# existir, e o de vendor/bin caso contrário.
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'

# Artisan pelo Sail, porque o PHP roda no container e não no host.
alias art='sail artisan'

# --- Sistema ---------------------------------------------------------------

# No Bazzite, o 'ujust update' atualiza a imagem, os Flatpaks e o brew de uma
# vez: é o caminho que a própria distro indica, e não o bootc direto.
alias os-status='rpm-ostree status'
alias os-update='ujust update'
alias os-rollback='rpm-ostree rollback'

# --- Geral -----------------------------------------------------------------

alias ..='cd ..'
alias ...='cd ../..'
alias mkdir='mkdir -p'
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ip='ip -color=auto'
