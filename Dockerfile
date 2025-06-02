# Stage 1: Build the app using Node
FROM node:20-alpine as builder
WORKDIR /app

# Copy package files first (better layer caching)
COPY Frontend/package*.json ./

# Install dependencies (clean cache to reduce size)
RUN npm install && npm cache clean --force

# Copy the rest of the frontend code
COPY Frontend .

# Fix permissions for Vite (if needed)
RUN chmod +x node_modules/.bin/vite

# Build the app (remove --yes if not needed)
RUN npx vite build

# Stage 2: Serve the app using Nginx
FROM nginx:alpine

# Remove default Nginx config
RUN rm -rf /etc/nginx/conf.d/default.conf

# Copy custom Nginx config (if any)
# COPY nginx.conf /etc/nginx/conf.d/

# Copy built files from builder
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80 (HTTP)
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
