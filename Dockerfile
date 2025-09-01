FROM nginx:alpine

# Copy dist files to nginx html directory
COPY dist/ /usr/share/nginx/html/

# Copy a simple nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
