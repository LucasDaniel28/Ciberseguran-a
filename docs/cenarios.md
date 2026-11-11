# Cenários de laboratório

Este documento orienta a observação de três cenários. Execute-os somente em VMs próprias, isoladas e com contas fictícias. A versão dos serviços e do Medusa pode alterar os parâmetros disponíveis; confira a ajuda local antes de executar.

## 1. FTP – autenticação com credenciais de teste

**Objetivo:** verificar se o serviço FTP de laboratório aceita uma senha fraca e observar como as falhas são registradas.

Pré-requisitos:
- Metasploitable 2 iniciado na rede isolada.
- Serviço FTP habilitado no alvo.
- Uma conta de laboratório criada ou disponibilizada pelo próprio exercício.
- Wordlists fictícias deste repositório.

Confira os módulos instalados:

```bash
medusa -d
```

Exemplo de execução restrito ao IP ilustrativo do laboratório:

```bash
./scripts/medusa-lab.sh 192.168.56.20 ftp -U wordlists/usuarios-lab.txt -P wordlists/senhas-lab.txt
```

Observe se a autenticação é aceita, se há limitação de tentativas e quais eventos aparecem nos logs do serviço. O endereço deve ser substituído pelo IP privado real da VM.

## 2. DVWA – formulário Web

**Objetivo:** compreender por que formulários Web exigem tratamento diferente de serviços como FTP.

1. Instale e execute DVWA em uma VM/contêiner isolado, seguindo a documentação oficial.
2. Acesse a aplicação pelo navegador do Kali usando o IP privado do laboratório.
3. Faça login manual e confirme o funcionamento da aplicação.
4. Abra as ferramentas de desenvolvedor do navegador ou um proxy de teste local para observar método HTTP, caminho, parâmetros, cookies e resposta.
5. Repita a observação em cada nível de segurança do DVWA, se aplicável, e registre as diferenças.
6. Verifique se há atraso, limitação de tentativas, CAPTCHA, bloqueio ou registro de falhas.

A automação depende da versão do DVWA e da requisição HTTP exata. Não existe um comando universal do Medusa para todo formulário. Só configure um teste automatizado depois de confirmar que a versão instalada do Medusa possui um módulo compatível e de entender os parâmetros exigidos. Não publique cookies, tokens CSRF, sessões ou credenciais.

## 3. SMB – enumeração e password spraying

**Objetivo:** estudar a exposição de informações de contas e o risco de uma senha fraca compartilhada por vários usuários.

- Use apenas contas de teste criadas para o laboratório.
- Identifique a configuração SMB do alvo e registre quais informações são expostas a um usuário sem privilégios.
- Evite enumeração anônima fora do exercício autorizado.
- Faça o teste de spraying somente com uma senha fictícia deliberadamente configurada para o laboratório.

Exemplo ilustrativo, usando uma única senha fictícia:

```bash
./scripts/medusa-lab.sh 192.168.56.20 smbnt -U wordlists/usuarios-lab.txt -p 'Lab@2026!'
```

Confirme que o módulo `smbnt` existe na instalação e que o serviço de destino é o alvo correto. Não use listas de contas obtidas de pessoas ou organizações reais.

## 4. Modelo de registro

Copie e preencha para cada cenário:

| Campo | Registro |
|---|---|
| Data/hora | A preencher |
| Kali / Medusa | A preencher |
| Alvo e IP privado | A preencher |
| Serviço / módulo | A preencher |
| Contas fictícias testadas | A preencher |
| Resultado observado | A preencher |
| Evidência sanitizada | A preencher |
| Mitigação recomendada | A preencher |

Não registre como executado um teste que ainda não foi realizado. Na publicação, oculte nomes, endereços e qualquer dado sensível.
