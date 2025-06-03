# Stage 1: Build Stage
FROM node:18 AS build

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install --production

# Copy source code
COPY . .

# Stage 2: Production Image
FROM node:18-alpine

WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app /app

# Expose the backend port (update if your app uses a different port)
EXPOSE 8000

# Run the server
CMD ["node", "server.js"]
