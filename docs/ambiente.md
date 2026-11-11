# Configuração do ambiente

## Requisitos

- Oracle VirtualBox.
- Kali Linux atualizado.
- Metasploitable 2 importado como VM.
- DVWA opcional, em uma VM ou contêiner separado.
- Espaço em disco e memória suficientes para executar as VMs simultaneamente.

## Rede isolada

1. Desligue as máquinas virtuais.
2. No VirtualBox, abra **Configurações > Rede** de cada VM.
3. Escolha **Adaptador somente-anfitrião (Host-Only)** ou **Rede Interna (Internal Network)**.
4. Configure as VMs no mesmo segmento virtual.
5. Não use modo Bridge, não configure redirecionamento de portas e não exponha os serviços à Internet.
6. Tire um snapshot de cada VM antes dos testes.

A rede Host-Only permite comunicação entre o host e as VMs. A Internal Network restringe a comunicação às VMs conectadas à mesma rede interna. Escolha a opção que melhor atende ao isolamento pretendido.

## Endereçamento ilustrativo

| Máquina | IP de exemplo |
|---|---|
| Kali Linux | 192.168.56.10 |
| Metasploitable 2 | 192.168.56.20 |
| DVWA | 192.168.56.30 |

Esses endereços são apenas exemplos e não configuram a rede automaticamente. Confira o endereço real em cada VM:

```bash
ip -br address
ip route
```

A partir do Kali, verifique apenas a conectividade com o endereço do seu alvo de laboratório:

```bash
ping -c 3 192.168.56.20
```

Se não houver conectividade, confira adaptadores, máscara, endereço e firewall. Não altere a rede para Bridge como solução improvisada.

## Preparar o Medusa

Confira se está instalado e veja a ajuda:

```bash
medusa -h
medusa -d
```

O segundo comando lista os módulos disponíveis na compilação instalada. Consulte a documentação da versão local para confirmar parâmetros e módulos antes dos exercícios.

## Cuidados

- Use somente contas e senhas fictícias.
- Não use credenciais pessoais, corporativas ou reutilizadas.
- Não compartilhe a rede vulnerável com redes de produção.
- Restaure snapshots se uma atividade alterar o serviço.
- Ao terminar, desligue as VMs e remova serviços temporários.
