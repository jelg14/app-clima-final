# Usa NGINX oficial ligero
FROM nginx:alpine

# Borra archivos web por defecto para evitar conflictos
RUN rm -rf /usr/share/nginx/html/*

# Copia la app Flutter Web ya compilada dentro de Docker
# para ello ejecutar flutter build web --release
COPY build/web /usr/share/nginx/html

# Expone puerto 80 para HTTP
EXPOSE 80

# Ejecuta nginx en primer plano
CMD ["nginx", "-g", "daemon off;"]
