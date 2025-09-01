FROM python:3.11-alpine
WORKDIR /app
COPY dist/ ./dist/
EXPOSE 8000
CMD ["python", "-m", "http.server", "8000", "--bind", "0.0.0.0", "--directory", "dist"]
