# Monitor
## Introdução

O objetivo dos arquivos dessa pasta é realizar a análise das máquinas de uma rede interna usando o nmap, ping e outros comandos.

## Procedimento

### Obtenha os arquivos com a lista de IPs

1. Faça um download no formato (.csv) da planilha contendo a lista de máquinas.
2. Salve esse arquivo com o nome de planilha.csv
3. Execute o script generate.sh

## Descrição dos arquivos

### download_csv.prg

Baixa o arquivo (.csv) compartilhado na núvem.

### imp_planilha.prg

Importa do arquivo (.csv) baixado a lista de servidores. A lista consiste na descrição do servidor e seu respectivo endereço

### exec_nmap.prg

Executa o nmap na lista de servidores obtida




