# Laboratório de força bruta controlada com Medusa

Projeto prático de estudo de segurança ofensiva e defensiva com Kali Linux, Medusa, Metasploitable 2 e DVWA. O objetivo é compreender como funcionam ataques de autenticação em ambiente isolado e como reduzir esses riscos.

> **Uso autorizado בלבד:** execute os testes somente em máquinas próprias ou com autorização explícita. Use uma rede virtual isolada, contas fictícias e senhas descartáveis. Nunca direcione os testes a sistemas públicos ou de terceiros.

## Objetivos

- Preparar um laboratório isolado no VirtualBox.
- Estudar brute force, password spraying, enumeração e wordlists.
- Avaliar serviços FTP, SMB e formulários Web em alvos intencionalmente vulneráveis.
- Documentar evidências e propor medidas de mitigação.

## Estrutura

```text
.
├── README.md
├── docs/
│   ├── ambiente.md
│   ├── cenarios.md
│   └── mitigacao.md
├── wordlists/
│   ├── usuarios-lab.txt
│   └── senhas-lab.txt
└── scripts/
    └── medusa-lab.sh
```

## Ambiente de laboratório

| Máquina | Função | IP ilustrativo |
|---|---|---|
| Kali Linux | Estação de auditoria | 192.168.56.10 |
| Metasploitable 2 | Alvo vulnerável | 192.168.56.20 |
| DVWA | Aplicação Web vulnerável (opcional) | 192.168.56.30 |

Os endereços são exemplos. Confirme os endereços reais da sua rede virtual antes de qualquer teste. Configure as VMs em **Host-Only** ou **Internal Network**, sem modo Bridge e sem encaminhamento de portas para a Internet. Faça snapshots antes das atividades.

Consulte [docs/ambiente.md](docs/ambiente.md).

## Ferramentas e conceitos

- **Medusa:** ferramenta modular para auditoria de autenticação em serviços de rede.
- **Kali Linux:** distribuição voltada a testes de segurança.
- **Metasploitable 2:** máquina virtual intencionalmente vulnerável para treinamento.
- **DVWA:** aplicação Web deliberadamente vulnerável para estudos.
- **Wordlist:** lista de candidatos usada em testes controlados.
- **Enumeração:** coleta de informações sobre usuários, grupos, serviços e compartilhamentos.
- **SMB:** protocolo de compartilhamento de arquivos e recursos em rede.

### Tipos de ataque

| Técnica | Definição |
|---|---|
| Brute force | Testar várias senhas contra uma conta. |
| Password spraying | Testar uma senha ou poucas senhas contra várias contas. |
| Credential stuffing | Testar pares de credenciais obtidos de vazamentos em outros serviços. |
| Dictionary attack | Testar candidatos de uma lista de palavras/senhas. |

## Cenários propostos

1. **FTP:** validar, com credenciais fictícias, se o serviço aceita senhas fracas.
2. **DVWA:** observar o comportamento do formulário de login e os controles de tentativas. A automação depende da versão, dos parâmetros HTTP, cookies e nível de segurança configurado.
3. **SMB:** estudar enumeração de usuários e password spraying controlado somente contra contas criadas para o laboratório.

Os passos, pré-requisitos e pontos de observação estão em [docs/cenarios.md](docs/cenarios.md). Verifique os módulos instalados com `medusa -d` e consulte `medusa -h` antes de adaptar qualquer comando. A sintaxe e a disponibilidade de módulos variam por versão.

## Wordlists de laboratório

Os arquivos em [wordlists/](wordlists/) contêm apenas nomes e senhas fictícias, curtas e criadas para este exercício. Não são listas de vazamentos nem devem ser ampliadas com dados pessoais ou credenciais reais.

## Script de apoio

O script [scripts/medusa-lab.sh](scripts/medusa-lab.sh) exige um IPv4 privado, um módulo e confirmação interativa antes de chamar o Medusa. Ele não procura alvos, não contorna bloqueios e não automatiza enumeração. Use somente dentro da rede isolada.

Exemplo ilustrativo para FTP:

```bash
chmod +x scripts/medusa-lab.sh
./scripts/medusa-lab.sh 192.168.56.20 ftp -U wordlists/usuarios-lab.txt -P wordlists/senhas-lab.txt
```

Exemplo ilustrativo de spraying SMB com uma única senha fictícia:

```bash
./scripts/medusa-lab.sh 192.168.56.20 smbnt -U wordlists/usuarios-lab.txt -p 'Lab@2026!'
```

Confirme primeiro que o módulo existe na sua instalação e que o serviço de destino é seu laboratório. Nunca reutilize senhas pessoais.

## Registro dos resultados

Para cada cenário, registre data, versões das ferramentas, configuração de rede, IP privado do alvo, módulo usado, quantidade de credenciais fictícias testadas, resultado observado, limitações e mitigação sugerida. Não declare um teste como concluído sem executá-lo e guardar evidência.

Capturas de tela podem ser adicionadas em `images/`, ocultando nomes de usuário, endereços e quaisquer dados sensíveis.

## Mitigações

- Exigir senhas longas, únicas e bloqueio de senhas comprometidas.
- Habilitar autenticação multifator (MFA).
- Aplicar limitação de tentativas e atrasos progressivos.
- Monitorar falhas e padrões distribuídos de autenticação.
- Restringir SMB por firewall e segmentação; desabilitar SMBv1.
- Desativar serviços desnecessários e evitar enumeração anônima.
- Preferir SFTP/SSH ou FTPS em vez de FTP sem criptografia.
- Revisar contas antigas, privilégios e políticas de autenticação.

Mais recomendações em [docs/mitigacao.md](docs/mitigacao.md).

## Checklist

- [ ] Criar as VMs e isolar a rede.
- [ ] Registrar versões e IPs reais do laboratório.
- [ ] Conferir os módulos disponíveis no Medusa.
- [ ] Executar e documentar o cenário FTP.
- [ ] Analisar o formulário DVWA e seus controles.
- [ ] Executar password spraying SMB somente com contas fictícias autorizadas.
- [ ] Registrar resultados e evidências sanitizadas.
- [ ] Relacionar cada achado a uma medida de mitigação.

## Referências

- [Medusa – código-fonte e documentação](https://github.com/jmk-foofus/medusa)
- [Kali Linux – documentação](https://www.kali.org/docs/)
- [Metasploitable 2 – Rapid7](https://docs.rapid7.com/metasploit/metasploitable-2/)
- [DVWA – projeto oficial](https://github.com/digininja/DVWA)
- [OWASP Authentication Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html)

---
**Status:** roteiro de laboratório. Os resultados práticos devem ser preenchidos após a execução real dos testes.
