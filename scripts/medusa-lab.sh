#!/usr/bin/env bash
set -Eeuo pipefail

usage() {
  cat <<'USAGE'
Uso:
  ./scripts/medusa-lab.sh IPV4_PRIVADO MODULO [argumentos do Medusa]

Exemplos (somente laboratório isolado):
  ./scripts/medusa-lab.sh 192.168.56.20 ftp -U wordlists/usuarios-lab.txt -P wordlists/senhas-lab.txt
  ./scripts/medusa-lab.sh 192.168.56.20 smbnt -U wordlists/usuarios-lab.txt -p 'Lab@2026!'

O script exige endereço IPv4 privado e confirmação interativa.
Ele não descobre alvos nem contorna bloqueios.
USAGE
}

if [[ $# -lt 3 ]]; then
  usage
  exit 2
fi

target="$1"
module="$2"
shift 2

if ! command -v medusa >/dev/null 2>&1; then
  echo "Erro: Medusa não encontrado. Instale/verifique a ferramenta no Kali." >&2
  exit 1
fi

# Aceita apenas IPv4 em faixas privadas RFC1918.
IFS='.' read -r a b c d extra <<< "$target"
if [[ -n "${extra:-}" || ! "$a" =~ ^[0-9]+$ || ! "$b" =~ ^[0-9]+$ || ! "$c" =~ ^[0-9]+$ || ! "$d" =~ ^[0-9]+$ ]]; then
  echo "Erro: informe um IPv4 válido de rede privada RFC1918." >&2
  exit 1
fi
for octet in "$a" "$b" "$c" "$d"; do
  if (( 10#$octet > 255 )); then
    echo "Erro: octeto IPv4 fora do intervalo." >&2
    exit 1
  fi
done

private=false
if (( 10#$a == 10 )); then
  private=true
elif (( 10#$a == 172 && 10#$b >= 16 && 10#$b <= 31 )); then
  private=true
elif (( 10#$a == 192 && 10#$b == 168 )); then
  private=true
fi

if [[ "$private" != true ]]; then
  echo "Erro: por segurança, o script aceita somente endereços RFC1918 (10/8, 172.16/12, 192.168/16)." >&2
  exit 1
fi

if [[ ! "$module" =~ ^[a-zA-Z0-9_-]+$ ]]; then
  echo "Erro: nome de módulo inválido." >&2
  exit 1
fi

echo "Alvo informado: $target"
echo "Módulo informado: $module"
echo "Confirme que este IP pertence a uma VM sua em rede isolada."
read -r -p "Digite LAB para autorizar a execução neste laboratório: " confirmation
if [[ "$confirmation" != "LAB" ]]; then
  echo "Execução cancelada."
  exit 1
fi

exec medusa -h "$target" -M "$module" "$@"
