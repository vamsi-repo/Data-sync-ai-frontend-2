FROM node:18-alpine
WORKDIR /app
COPY dist/ ./dist/
RUN npm install -g serve
EXPOSE 3000
CMD ["sh", "-c", "serve -s dist --listen 0.0.0.0:$PORT"]
