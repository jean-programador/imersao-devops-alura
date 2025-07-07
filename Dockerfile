FROM python:3.13.4-alpine3.22

# 2. Definir o diretório de trabalho
# Isso garante que todos os comandos subsequentes sejam executados neste diretório dentro do container.
WORKDIR /app

# 3. Copiar o arquivo de dependências
# Copiamos o requirements.txt primeiro para aproveitar o cache de camadas do Docker.
# Se este arquivo não mudar, o Docker não reinstalará as dependências em builds futuros.
COPY requirements.txt .

# 4. Instalar as dependências
# O --no-cache-dir ajuda a manter o tamanho da imagem menor.
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar o código da aplicação
# Copia todos os arquivos do projeto para o diretório de trabalho no container.
COPY . .

# 6. Expor a porta
# Informa ao Docker que o container escutará na porta 8000.
EXPOSE 8000

# 7. Comando para executar a aplicação
# Inicia o servidor Uvicorn. O host 0.0.0.0 é essencial para que a aplicação 
# seja acessível de fora do container.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]