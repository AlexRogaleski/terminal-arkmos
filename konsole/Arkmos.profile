# terminal-arkmos — perfil do Konsole com os valores do foot.ini do Arkmos.
# O install.sh copia este arquivo (não cria um link): o Konsole reescreve o
# perfil quando ele é editado pela interface, e trocaria o link por um arquivo.

[Appearance]
ColorScheme=TokyoNight
Font=JetBrainsMono Nerd Font,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1
UseFontLineChararacters=true

[Cursor Options]
CursorShape=1

[General]
Command=/bin/zsh
Name=Arkmos
Parent=FALLBACK/
TerminalCenter=false
TerminalMargin=8

[Interaction Options]
AutoCopySelectedText=false
TrimLeadingSpacesInSelectedText=true
TrimTrailingSpacesInSelectedText=true

[Keyboard]
KeyBindings=linux

[Scrolling]
HistoryMode=1
HistorySize=10000

[Terminal Features]
BlinkingCursorEnabled=true
