#!/bin/bash
#
# Cor Titulo Vermelho
VERMELHO='\0033[0;31m'
RESET='\033[0m' # Voltar a cor padrão

# Define o arquivo de log (padrão: access.log)
LOG_FILE="${1:-access.log}"

# Verifica se o arquivo existe
if [ ! -f "$LOG_FILE" ]; then
    echo "Erro: O arquivo $LOG_FILE nao existe!"
    exit 1
fi

while true; do
    echo ""
    echo -e "${VERMELHO}###### REDSCAN Prof. CARLOS ######${RESET}"
    echo "### ANALISADOR DE LOGS SIMPLES ###"
    echo "1 - Detectar XSS"
    echo "2 - Detectar SQL Injection"
    echo "3 - Detectar Directory Traversal"
    echo "4 - Detectar Scanners (User-Agent)"
    echo "5 - Acesso a arquivos sensiveis (.env, .git)"
    echo "6 - IPs com mais erros 404"
    echo "7 - Primeiro e ultimo acesso de um IP"
    echo "8 - User-Agent de um IP"
    echo "9 - Listar total de requisicoes por IP"
    echo "10 - Buscar por um arquivo especifico"
    echo "11 - Sair"
    echo "=================================="
    read -rp "Escolha uma opcao [1-11]: " opcao

    echo ""
    case $opcao in
        1)
            grep -iE "<script|%3Cscript" "$LOG_FILE"
            ;;
        2)
            grep -iE "union|select|insert|drop|%27|%22" "$LOG_FILE"
            ;;
        3)
            grep -E "\.\./|\.\.%2f" "$LOG_FILE"
            ;;
        4)
            grep -iE "nikto|nmap|sqlmap|acunetix|curl|masscan|python" "$LOG_FILE"
            ;;
        5)
            grep -iE "\.env|\.git|\.htaccess|\.bak" "$LOG_FILE"
            ;;
        6)
            grep " 404 " "$LOG_FILE" | cut -d " " -f 1 | sort | uniq -c | sort -nr | head -n 10
            ;;
        7)
            read -rp "Digite o IP: " ip
            echo "--- Primeiro Acesso ---"
            grep "$ip" "$LOG_FILE" | head -n 1
            echo "--- Ultimo Acesso ---"
            grep "$ip" "$LOG_FILE" | tail -n 1
            ;;
        8)
            read -rp "Digite o IP: " ip
            grep "$ip" "$LOG_FILE" | cut -d '"' -f 6 | sort | uniq
            ;;
        9)
            cut -d " " -f 1 "$LOG_FILE" | sort | uniq -c | sort -nr
            ;;
        10)
            read -rp "Nome do arquivo: " arquivo
            grep "$arquivo" "$LOG_FILE"
            ;;
        11)
            echo "Saindo..."
            break
            ;;
        *)
            echo "Opcao invalida!"
            ;;
    esac

    echo ""
    read -rp "Pressione Enter para continuar..."
done
