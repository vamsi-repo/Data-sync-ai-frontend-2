FROM node:18-alpine
WORKDIR /app

# Copy the built dist folder
COPY dist/ ./dist/

# Create a simple server file
RUN echo 'const express = require("express");' > server.js && \
    echo 'const path = require("path");' >> server.js && \
    echo 'const app = express();' >> server.js && \
    echo 'const port = process.env.PORT || 3000;' >> server.js && \
    echo 'app.use(express.static(path.join(__dirname, "dist")));' >> server.js && \
    echo 'app.get("*", (req, res) => res.sendFile(path.join(__dirname, "dist", "index.html")));' >> server.js && \
    echo 'app.listen(port, "0.0.0.0", () => console.log(`Server running on http://0.0.0.0:${port}`));' >> server.js

# Install express
RUN npm init -y && npm install express

# Expose port
EXPOSE 3000

# Start the server
CMD ["node", "server.js"]
