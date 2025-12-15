# Dockerfile
FROM node:18-alpine

# Create app directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm cache clean --force && \
    npm install --production

# Copy app source code
COPY . .

# Expose port
EXPOSE 3000

# Start the application
CMD ["node", "app.js"]