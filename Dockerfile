# ⚡ Stage 1: Build Stage (Installs dependencies and builds the app)
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json first (for caching layers)
COPY package*.json ./

# Install dependencies in production mode only (faster)
RUN npm ci 

# Copy application source code
COPY . .


CMD [ "npm","run","start" ]
