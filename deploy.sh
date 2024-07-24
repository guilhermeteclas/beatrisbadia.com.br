#!/bin/bash

#Deploy local com Apache

# Defina as variáveis de diretório
SOURCE_DIR="./src"
DEST_DIR="/var/www/html/beatris"
BUILD_INFO_FILE="$DEST_DIR/build_info.txt"
LOG_FILE="/tmp/deploy_log.txt"

# Limpar o arquivo de log antes de começar
> "$LOG_FILE"

# Obter a versão do package.json
VERSION=$(node -p "require('./package.json').version")

# Obter o hash do commit Git
COMMIT_HASH=$(git rev-parse --short HEAD)

# Obter a mensagem do commit mais recente
COMMIT_MESSAGE=$(git log -1 --pretty=format:%s)

# Obter a data e hora atual
BUILD_DATE=$(date +"%Y-%m-%d %H:%M:%S")

# Defina detalhes adicionais
DETAILS="Mensagem do Commit: $COMMIT_MESSAGE"

# Função para redirecionar a saída para o terminal e para o arquivo de log
log_and_display() {
  "$@" 2>&1 | tee -a "$LOG_FILE"
}

# Rodar o build do Tailwind CSS e capturar a saída
echo "Executando o build do Tailwind CSS..."
log_and_display npx tailwindcss -i "$SOURCE_DIR/assets/css/styles.css" -o "$SOURCE_DIR/assets/css/styles.min.css" --minify
echo "Build do Tailwind CSS concluído." | tee -a "$LOG_FILE"

# Verifique se o comando npx foi bem-sucedido
if [ $? -ne 0 ]; then
  echo "Erro ao executar o build do Tailwind CSS." | tee -a "$LOG_FILE"
  exit 1
fi

# Crie o diretório de destino se não existir
log_and_display sudo mkdir -p "$DEST_DIR"

# Copie todos os arquivos e diretórios de /src para /var/www/html/beatris
echo "Copiando arquivos para $DEST_DIR..."
log_and_display sudo cp -r "$SOURCE_DIR/"* "$DEST_DIR/"

# Adicionar informações sobre a cópia de arquivos ao log
echo "Arquivos copiados de $SOURCE_DIR para $DEST_DIR" | tee -a "$LOG_FILE"

# Criar ou atualizar o arquivo de registro com a versão, hash do commit, mensagem do commit, data/hora e detalhes
{
  echo "Versão: $VERSION"
  echo "Hash do Commit: $COMMIT_HASH"
  echo "Mensagem do Commit: $COMMIT_MESSAGE"
  echo "Data/Hora do Build: $BUILD_DATE"
  echo ""  # Linha vazia
  echo "Detalhes:"
  cat "$LOG_FILE"
} | sudo tee "$BUILD_INFO_FILE" > /dev/null

# Exiba uma mensagem de conclusão
echo "Informações do build registradas em $BUILD_INFO_FILE"
