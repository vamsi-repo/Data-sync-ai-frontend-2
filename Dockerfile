FROM node:18-alpine
WORKDIR /app
COPY dist/ ./dist/
RUN echo 'const express = require("express"); \
const path = require("path"); \
const app = express(); \
const port = process.env.PORT || 3000; \
app.use(express.static(path.join(__dirname, "dist"))); \
app.get("*", (req, res) => res.sendFile(path.join(__dirname, "dist", "index.html"))); \
app.listen(port, "0.0.0.0", () => console.log(`Frontend server running on http://0.0.0.0:${port}`));' > server.js
RUN npm init -y && npm install express
EXPOSE 3000
CMD ["node", "server.js"]
