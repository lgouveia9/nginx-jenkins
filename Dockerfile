# Use a imagem oficial do Nginx como base
FROM nginx:latest

# Copie o arquivo de configuração personalizado para o diretório de configuração do Nginx na imagem
#COPY nginx.conf /etc/nginx/nginx.conf

# Copie o conteúdo do seu aplicativo para o diretório padrão do Nginx (geralmente /usr/share/nginx/html/)
#COPY ./seu_app /usr/share/nginx/html/

# Exponha a porta 80 para tráfego HTTP
EXPOSE 80

# Comando para iniciar o Nginx quando o contêiner for iniciado
CMD ["nginx", "-g", "daemon off;"]
