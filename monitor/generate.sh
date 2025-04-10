#/bin/bash

echo "Baixando a lista de servidores"
hbmclip https://raw.githubusercontent.com/vlademirodc/hbmclip/refs/heads/main/monitor/download_csv.prg
echo "Importando os dados de planilha.csv"
hbmclip https://raw.githubusercontent.com/vlademirodc/hbmclip/refs/heads/main/monitor/imp_planilha.prg
echo "Gerando o nmap"
hbmclip https://raw.githubusercontent.com/vlademirodc/hbmclip/refs/heads/main/monitor/imp_nmap.prg
