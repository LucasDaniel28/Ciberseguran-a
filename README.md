# Laboratório de auditoria de autenticação com Kali Linux e Medusa

![Status](https://img.shields.io/badge/status-em%20desenvolvimento-yellow)
![Plataforma](https://img.shields.io/badge/plataforma-Kali%20Linux-blue)
![Finalidade](https://img.shields.io/badge/finalidade-estudo%20e%20laborat%C3%B3rio-informational)

## 1. Sobre o projeto

Este repositório documenta um laboratório prático de **cibersegurança**, com foco na compreensão de ataques contra mecanismos de autenticação e nas medidas que podem ser adotadas para preveni-los.

A atividade utiliza o Kali Linux e a ferramenta Medusa em conjunto com ambientes intencionalmente vulneráveis, como Metasploitable 2 e DVWA. Os cenários propostos abordam serviços FTP, formulários de autenticação Web e SMB.

O projeto tem finalidade exclusivamente educacional: demonstrar como credenciais fracas, exposição de informações e ausência de controles de autenticação podem aumentar o risco de acesso indevido. Cada teste deve ser realizado em máquinas virtuais próprias, com contas fictícias e em uma rede isolada.

> **Aviso de uso responsável:** não execute testes contra endereços públicos, redes corporativas, contas de terceiros ou qualquer sistema sem autorização expressa. Utilize exclusivamente o laboratório descrito neste documento. Não armazene nem publique credenciais reais, hashes, cookies, tokens ou dados pessoais.

## 2. Objetivos

- Configurar um ambiente isolado com Kali Linux e máquinas virtuais vulneráveis.
- Conhecer o funcionamento do Medusa e seus módulos de autenticação.
- Compreender brute force, dictionary attack, password spraying e credential stuffing.
- Preparar wordlists pequenas com usuários e senhas fictícias.
- Estudar enumeração de serviços, usuários e compartilhamentos.
- Observar os riscos associados a FTP, formulários Web e SMB.
- Registrar os procedimentos e resultados de forma reproduzível.
- Relacionar as falhas observadas às respectivas medidas de mitigação.

## 3. Organização dos arquivos

```text
Ciberseguran-a/
├── README.md
├── .gitignore
├── docs/
│   ├── ambiente.md
│   ├── cenarios.md
│   └── mitigacao.md
├── images/
│   └── .gitkeep
├── scripts/
│   └── medusa-lab.sh
└── wordlists/
    ├── usuarios-lab.txt
    └── senhas-lab.txt
```

| Caminho | Descrição |
|---|---|
| `README.md` | Apresentação, objetivos, instruções gerais e referências do projeto. |
| `docs/ambiente.md` | Preparação das VMs e configuração da rede isolada. |
| `docs/cenarios.md` | Roteiro dos exercícios FTP, DVWA e SMB e modelo de registro. |
| `docs/mitigacao.md` | Recomendações de proteção para autenticação, FTP, SMB e aplicações Web. |
| `wordlists/` | Listas pequenas de usuários e senhas fictícias para o laboratório. |
| `scripts/medusa-lab.sh` | Invólucro com validação de IP privado e confirmação interativa antes de chamar o Medusa. |
| `images/` | Local reservado para capturas de tela sanitizadas. |

## 4. Ambiente de laboratório

### 4.1. Componentes

| Componente | Finalidade |
|---|---|
| VirtualBox | Executar as máquinas virtuais. |
| Kali Linux | Sistema utilizado para estudar e executar as ferramentas de auditoria. |
| Medusa | Realizar testes controlados de autenticação em serviços compatíveis. |
| Metasploitable 2 | Máquina virtual intencionalmente vulnerável para exercícios de segurança. |
| DVWA | Aplicação Web deliberadamente vulnerável para estudo de segurança em formulários. |

### 4.2. Topologia ilustrativa

| Máquina | Papel | Endereço de exemplo |
|---|---|---|
| Kali Linux | Estação de auditoria | `192.168.56.10` |
| Metasploitable 2 | Alvo de laboratório | `192.168.56.20` |
| DVWA | Aplicação Web (opcional) | `192.168.56.30` |

Os endereços acima são exemplos didáticos, não configurações garantidas. Consulte o endereço efetivo em cada VM e adapte a documentação ao ambiente instalado.

### 4.3. Isolamento da rede

Configure as máquinas no VirtualBox usando **Host-Only** ou **Internal Network**. Todas as VMs que precisarem se comunicar devem estar no mesmo segmento virtual. Não utilize modo Bridge nem redirecione portas dos serviços vulneráveis para a Internet. Faça snapshots antes dos exercícios e restaure-os quando necessário.

Para conferir a configuração de rede dentro do Kali:

```bash
ip -br address
ip route
```

O roteiro completo está em [docs/ambiente.md](docs/ambiente.md).

## 5. Conceitos estudados

| Conceito | Explicação |
|---|---|
| **Brute force** | Tentativa sistemática de várias senhas contra uma conta. |
| **Dictionary attack** | Teste de senhas candidatas presentes em uma lista de palavras. |
| **Password spraying** | Teste de uma senha ou de poucas senhas contra várias contas, em vez de muitas senhas contra uma única conta. |
| **Credential stuffing** | Uso de pares de usuário e senha obtidos de vazamentos para tentar autenticação em outros serviços. |
| **Wordlist** | Arquivo de texto com candidatos usados em um teste. |
| **Enumeração** | Coleta de informações sobre serviços, usuários, grupos e compartilhamentos. |
| **SMB** | Protocolo de rede usado para compartilhar arquivos, impressoras e outros recursos. |
| **MFA** | Autenticação multifator, que acrescenta uma etapa de verificação além da senha. |
| **Hash** | Resultado de uma função criptográfica; sistemas de autenticação podem armazenar hashes de senhas em vez de texto puro. |

### 5.1. Ferramentas

- **Medusa:** ferramenta modular de auditoria de autenticação em serviços de rede. A disponibilidade e a sintaxe dos módulos dependem da versão instalada.
- **Kali Linux:** distribuição Linux que reúne ferramentas voltadas a testes de segurança e análise de redes.
- **Metasploitable 2:** ambiente vulnerável intencionalmente, criado para treinamento.
- **DVWA:** aplicação Web de treinamento que permite estudar vulnerabilidades em diferentes níveis de segurança.
- **smbclient:** cliente de linha de comando para interagir com compartilhamentos SMB.

## 6. Preparação das ferramentas e wordlists

No Kali, confira se o Medusa está disponível:

```bash
medusa -h
medusa -d
```

O primeiro comando exibe a ajuda geral e o segundo lista os módulos disponíveis na instalação. Consulte também a ajuda específica do módulo antes de realizar qualquer exercício.

As listas em [wordlists/](wordlists/) são intencionalmente pequenas e contêm somente nomes e senhas fictícias. Elas existem para demonstrar o formato de uma wordlist e permitir testes previsíveis no ambiente controlado. Não são listas de vazamentos e não devem receber dados de pessoas reais.

## 7. Cenários práticos

O desafio está dividido em três cenários. Os procedimentos e as observações esperadas estão descritos em [docs/cenarios.md](docs/cenarios.md).

### 7.1. FTP – teste de autenticação

**Objetivo:** verificar, no serviço FTP da máquina de laboratório, como credenciais fracas podem comprometer a autenticação.

O exercício utiliza o módulo FTP do Medusa, uma lista fictícia de usuários e outra de senhas. Observe se o serviço aceita alguma credencial de teste, se há limitação de tentativas e quais registros são gerados pelo serviço.

Exemplo para o IP ilustrativo do laboratório:

```bash
chmod +x scripts/medusa-lab.sh
./scripts/medusa-lab.sh 192.168.56.20 ftp -U wordlists/usuarios-lab.txt -P wordlists/senhas-lab.txt
```

Substitua o IP pelo endereço privado real da VM e confirme que o serviço pertence ao seu laboratório. O exemplo não deve ser usado contra qualquer outro host.

### 7.2. DVWA – formulário de autenticação Web

**Objetivo:** observar como uma aplicação Web trata tentativas de autenticação e quais controles dificultam a automação abusiva.

Primeiro, realize o acesso manual e inspecione a requisição do formulário. Registre método HTTP, caminho, nomes dos parâmetros, cookies, tokens de sessão/CSRF e como a aplicação sinaliza falha ou sucesso.

A automação de formulários Web depende da versão do DVWA, do nível de segurança e dos detalhes da requisição. Portanto, não existe um comando genérico garantido para todas as instalações. Só adapte o Medusa se a versão instalada oferecer um módulo compatível e se os parâmetros tiverem sido confirmados no próprio laboratório. Não publique cookies, tokens ou dados de sessão.

### 7.3. SMB – enumeração e password spraying

**Objetivo:** compreender quais informações podem ser expostas por SMB e por que reutilizar uma senha fraca em várias contas representa risco.

O exercício deve utilizar somente contas fictícias preparadas para o laboratório. Observe as informações de usuários, grupos e compartilhamentos que o serviço disponibiliza e verifique se o acesso anônimo está indevidamente habilitado.

Exemplo ilustrativo de spraying com uma única senha fictícia:

```bash
./scripts/medusa-lab.sh 192.168.56.20 smbnt -U wordlists/usuarios-lab.txt -p 'Lab@2026!'
```

Confirme antes que o módulo `smbnt` está disponível e que o endereço é o da VM autorizada. O objetivo é estudar o risco, não obter acesso a contas reais.

## 8. Script de apoio

O arquivo [scripts/medusa-lab.sh](scripts/medusa-lab.sh) funciona como um invólucro simples para o Medusa. Ele:

- Exige endereço IPv4 privado nas faixas RFC1918.
- Recebe o módulo e os argumentos que serão repassados ao Medusa.
- Solicita confirmação digitada antes da execução.
- Não descobre hosts, não enumera redes e não tenta contornar mecanismos de bloqueio.

Para permitir sua execução:

```bash
chmod +x scripts/medusa-lab.sh
```

Consulte a ajuda do próprio script executando-o sem argumentos. A validação de IP é uma proteção auxiliar, não substitui o isolamento da rede nem a autorização do proprietário do sistema.

## 9. Documentação e análise dos resultados

Cada cenário deve ter um registro próprio. Inclua:

1. Data e horário do teste.
2. Versões do Kali Linux, Medusa e serviço-alvo.
3. Topologia, endereço privado e identificação da VM.
4. Módulo e parâmetros utilizados, sem divulgar credenciais.
5. Quantidade de usuários e senhas fictícias testadas.
6. Resultado observado e interpretação.
7. Evidência visual sanitizada, quando disponível.
8. Limitações encontradas e recomendações de mitigação.

Modelo resumido:

| Campo | Preenchimento |
|---|---|
| Cenário | FTP, DVWA ou SMB |
| Data e horário | A preencher após a execução |
| Versões das ferramentas | A preencher |
| IP privado do alvo | A preencher |
| Procedimento realizado | A preencher |
| Resultado observado | A preencher |
| Evidência | Caminho da captura sanitizada |
| Risco identificado | A preencher |
| Mitigação proposta | A preencher |

As capturas podem ser organizadas em `images/`. Oculte credenciais, nomes de usuários reais, tokens, cookies, endereços públicos e qualquer informação pessoal. Não marque os exercícios como concluídos antes de executá-los.

## 10. Medidas de prevenção e mitigação

Os testes demonstram por que a proteção de credenciais precisa combinar controles técnicos e boas práticas:

- Utilizar senhas longas, únicas e não reutilizadas.
- Bloquear senhas comuns ou conhecidas por terem sido comprometidas.
- Habilitar MFA, especialmente para acessos remotos e contas privilegiadas.
- Implementar limitação de tentativas e atrasos progressivos.
- Monitorar falhas de autenticação e padrões distribuídos de password spraying.
- Restringir SMB por firewall e segmentação de rede; desabilitar SMBv1.
- Desativar serviços desnecessários e evitar enumeração anônima.
- Preferir SFTP ou FTPS em vez de FTP sem criptografia.
- Revisar contas antigas, permissões e privilégios.
- Proteger sessões e tokens em aplicações Web.

A análise detalhada está em [docs/mitigacao.md](docs/mitigacao.md).

## 11. Checklist do desafio

- [ ] Preparar Kali Linux e Metasploitable 2 no VirtualBox.
- [ ] Configurar rede Host-Only ou Internal Network.
- [ ] Registrar endereços IP e versões reais das ferramentas.
- [ ] Verificar os módulos disponíveis no Medusa.
- [ ] Preparar e revisar as wordlists fictícias.
- [ ] Executar e documentar o cenário FTP.
- [ ] Instalar/abrir DVWA e analisar manualmente o formulário.
- [ ] Avaliar a possibilidade de automação compatível no DVWA.
- [ ] Estudar enumeração SMB com contas de laboratório.
- [ ] Executar password spraying somente contra contas fictícias autorizadas.
- [ ] Registrar resultados, limitações e evidências sanitizadas.
- [ ] Relacionar cada achado a uma medida de mitigação.

## 12. Conclusão

O laboratório demonstra que senhas fracas, exposição desnecessária de informações e ausência de controles de autenticação podem facilitar acessos indevidos. Também evidencia que uma auditoria responsável não termina na identificação de uma falha: é necessário registrar o contexto, avaliar o impacto e propor medidas de correção.

Este repositório reúne o roteiro, os arquivos de apoio e as recomendações para reproduzir os estudos em ambiente controlado. Os resultados e as capturas devem ser acrescentados conforme os testes forem realmente realizados.

## 13. Referências

- [Medusa – código-fonte e documentação](https://github.com/jmk-foofus/medusa)
- [Kali Linux – documentação oficial](https://www.kali.org/docs/)
- [Metasploitable 2 – Rapid7](https://docs.rapid7.com/metasploit/metasploitable-2/)
- [DVWA – projeto oficial](https://github.com/digininja/DVWA)
- [OWASP Authentication Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html)
- [OWASP Credential Stuffing Prevention Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Credential_Stuffing_Prevention_Cheat_Sheet.html)
- [Microsoft – SMB Security](https://learn.microsoft.com/en-us/windows-server/storage/file-server/smb-security)

---

**Status do projeto:** documentação e arquivos de apoio publicados. Os resultados experimentais devem ser preenchidos após a execução dos cenários no laboratório.
