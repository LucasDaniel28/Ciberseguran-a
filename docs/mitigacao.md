# Recomendações de mitigação

## Política de senhas

- Exigir senhas longas e exclusivas para cada serviço.
- Bloquear senhas comuns ou conhecidas por terem sido comprometidas.
- Incentivar gerenciadores de senhas.
- Evitar regras que levem usuários a pequenas variações previsíveis de uma senha antiga.

## Proteção de autenticação

- Habilitar MFA, especialmente para acesso remoto e contas privilegiadas.
- Aplicar limitação de tentativas e atrasos progressivos.
- Monitorar falhas por conta, origem e serviço para identificar brute force e password spraying.
- Projetar bloqueios com cuidado para que terceiros não consigam provocar negação de serviço bloqueando contas de usuários legítimos.
- Alertar sobre tentativas distribuídas e padrões anormais.

## FTP e transferência de arquivos

- Desabilitar FTP simples quando não for necessário.
- Preferir SFTP (sobre SSH) ou FTPS.
- Restringir acesso por firewall e permitir somente origens necessárias.
- Desabilitar contas anônimas e revisar permissões de diretórios.

## SMB

- Desabilitar SMBv1.
- Restringir portas SMB às redes e máquinas que realmente precisam do serviço.
- Exigir autenticação e permissões mínimas.
- Evitar compartilhamentos com escrita ou leitura ampla.
- Desabilitar enumeração anônima de usuários e compartilhamentos quando não for necessária.
- Manter sistemas atualizados e monitorar eventos de autenticação.

## Aplicações Web

- Usar MFA quando adequado.
- Implementar rate limiting no servidor, não apenas no navegador.
- Aplicar proteção contra automação abusiva sem depender exclusivamente de CAPTCHA.
- Proteger sessões, cookies e tokens CSRF.
- Registrar tentativas malsucedidas sem armazenar senhas.
- Retornar mensagens de erro que não revelem se o usuário existe.

## Monitoramento e resposta

- Centralizar logs de autenticação.
- Criar alertas para volume anormal de falhas e tentativas em várias contas.
- Investigar origem, horário, serviço e contas afetadas.
- Revogar sessões suspeitas e redefinir credenciais comprometidas.
- Documentar a resposta e revisar controles após o incidente.

## Referências

- [OWASP Authentication Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html)
- [OWASP Credential Stuffing Prevention Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Credential_Stuffing_Prevention_Cheat_Sheet.html)
- [Microsoft SMB Security](https://learn.microsoft.com/en-us/windows-server/storage/file-server/smb-security)
