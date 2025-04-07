#/bin/bash

echo "Importando os dados de planilha.csv"
hbmclip https://raw.githubusercontent.com/vlademirodc/hbmclip/refs/heads/main/monitor/imp_planilha.prg
echo "Gerando o nmap"
hbmclip https://raw.githubusercontent.com/vlademirodc/hbmclip/refs/heads/main/monitor/imp_nmap.prg
