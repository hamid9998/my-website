# Builder stage: install production dependencies
FROM node:18-alpine AS builder
WORKDIR /app

# Install production dependencies (use package-lock if present)
COPY package*.json ./
RUN npm ci --only=production

# Copy application files
COPY . .

# Runtime stage (smaller image)
FROM node:18-alpine
WORKDIR /app

ENV NODE_ENV=production

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy production deps and app files from the builder
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app .

USER appuser

# Allow mapping of the exposed port at runtime
EXPOSE 3000

CMD ["node", "app.js"]