FROM node:18-alpine

WORKDIR /app

# Copy the pre-built dist folder
COPY dist/ ./dist/

# Install serve globally
RUN npm install -g serve

# Expose port
EXPOSE 3000

# Serve the static files from dist folder
CMD ["serve", "-s", "dist", "-l", "3000"]
