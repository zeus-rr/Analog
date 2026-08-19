Script para analise de log do apache2
RedScan Academy

Utilizando os comandos propostos na aula, desenvolva um script simples para analise de log sem utilizar Ai.
 
Opções de Análise de Ataques para o Script.
  
1 - Detectar possíveis ataques de XSS (Cross-Site Scripting)
grep -iE "<script|%3Cscript" access.log

Busca por URLs que contenham <script> ou sua forma codificada %3Cscript.
  
2 - Detectar tentativas de SQL Injection
grep -iE "union|select|insert|drop|%27|%22" access.log

Busca palavras-chave comuns em SQL Injection ou seus equivalentes codificados.  

3 - Detectar varredura de diretórios (Directory Traversal)
grep -E "\.\./|\.\.%2f" access.log

Detecta padrões de subida de diretório (../) e variações URL-encoded.  

4 - Detectar possíveis ataques por scanners (User-Agent suspeito)
grep -iE "nikto|nmap|sqlmap|acunetix|curl|masscan|python" access.log

Detecta ferramentas comuns usadas para varredura ou exploração.  

5 - Identificar tentativas de acesso a arquivos sensíveis (.env, .git, etc.)
grep -iE "\.env|\.git|\.htaccess|\.bak" access.log

Tenta localizar requisições a arquivos críticos.  

6 - Detectar possíveis ataques de força bruta a arquivos/pastas
grep " 404 " access.log | cut -d " " -f 1 | sort | uniq -c | sort -nr | head

Lista os IPs que mais geraram requisições 404. Isso pode indicar brute force de diretórios inexistentes.


7 -  Primeiro e ultimo acesso de um IP suspeito.  
 grep "IP" access.log | head -n1
 grep "IP" access.log | tail -n1


8 - Localizar user-agent utilizado por um IP suspeito  
grep "IP_SUSPEITO" access.log | cut -d '"' -f 6 | sort | uniq

9- Listar os ips e verificar o numero de requisições
cat access.log | cut -d " " -f 1 | sort | uniq -c

10- Localizar acesso a um determinado arquivo sensível
grep "arquivosensivel" access.log
<img width="377" height="254" alt="image" src="https://github.com/user-attachments/assets/1c33a3bd-1edd-4e92-83b4-a129b6d9b15a" />


