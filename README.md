# terminal-arkmos

O terminal do [Arkmos](https://github.com/AlexRogaleski/arkmos) numa conta do
Bazzite (KDE): os mesmos módulos de Zsh, o mesmo prompt do Starship e as mesmas
cores Tokyo Night, sem mexer na imagem do sistema.

```bash
git clone https://github.com/AlexRogaleski/terminal-arkmos ~/Projetos/terminal-arkmos
~/Projetos/terminal-arkmos/install.sh
```

Depois, é só abrir um Konsole novo.

## O que entra

| | Arkmos | aqui |
|---|---|---|
| Shell | Zsh, config em `/usr/share/arkmos/zsh` | Zsh, config neste repositório |
| Entrada | `ZDOTDIR` em `/etc/zshenv` | primeira linha do `~/.zshrc` |
| Prompt | Starship, `/usr/share/arkmos/starship.toml` | Starship, `starship.toml` daqui |
| Plugins | autosuggestions e syntax-highlighting do RPM | os mesmos, do Homebrew |
| Ferramentas | eza, bat, fd, rg, fzf, zoxide, mise, nvim, lazygit | as mesmas (`Brewfile`; o fzf é o do Bazzite) |
| Terminal | foot, Tokyo Night, 90% de opacidade | Konsole, perfil `Arkmos` com os mesmos valores |

Atalhos: `Ctrl+R` busca no histórico (fzf), `Ctrl+T` busca arquivos,
`Alt+C` entra em diretórios, `↑` busca pelo que já está digitado e
`Ctrl+X Ctrl+E` abre a linha no editor. Os aliases estão em `zsh/aliases.zsh`.

## Como fica na conta

```
~/.zshrc                           seu; a 1ª linha carrega zsh/init.zsh
~/.local/state/zsh/history         histórico
~/.local/share/konsole/            tema e perfil (cópias)
```

Os módulos são lidos direto do repositório: um `git pull` já vale no
próximo terminal. O Konsole é exceção, porque ele reescreve o próprio perfil:
depois de mudar algo em `konsole/`, rode o `install.sh` de novo.

## Ajustes desta máquina

O `~/.zshrc` continua sendo um arquivo comum. A primeira linha carrega o
`zsh/init.zsh` daqui, e o que vier depois dela vale só nesta máquina, com a
última palavra sobre o repositório: modo vi, outro editor, PATH de Flutter e
Android (há exemplos comentados). Instaladores que escrevem no `~/.zshrc`,
como o lerd e o nvm, continuam funcionando.

O `install.sh` só cria o `~/.zshrc` se ele ainda não carrega o `init.zsh`; o
anterior vai para o backup.

## Desfazer

O `install.sh` guarda o que substitui em
`~/.local/state/terminal-arkmos/backup-<data>/`, com os mesmos caminhos
relativos ao `$HOME`. Para voltar, mova o `.zshrc` de lá de volta para o `$HOME`. O perfil antigo do Konsole continua em `~/.local/share/konsole` e pode
ser escolhido de novo em *Configurações → Configurar o Konsole → Perfis*.
