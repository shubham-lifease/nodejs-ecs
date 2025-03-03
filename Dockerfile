# ⚡ Stage 1: Build Stage (Installs dependencies and builds the app)
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json first (for caching layers)
COPY package*.json ./

# Install dependencies in production mode only (faster)
RUN npm ci --only=production

# Copy application source code
COPY . .

# Build the application (if needed, e.g., TypeScript)
RUN npm run build || echo "No build step needed"

# ⚡ Stage 2: Production Stage (Runs the app with minimal footprint)
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy built app and dependencies from builder stage
COPY --from=builder /app .

# Ensure node_modules exist
RUN ls -la node_modules || echo "node_modules not found!"

# Set a non-root user for better security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
