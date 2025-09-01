FROM nginx:alpine

# Remove default nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy our files
COPY dist/ /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Ensure nginx uses our port
EXPOSE 3000

# Override the default command to be explicit about the port
CMD ["sh", "-c", "nginx -g 'daemon off;'"]
