# Stage 1: Build React app with Vite
FROM node:20 AS build
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy all source files and build the app
COPY . .
RUN npm run build  # Vite outputs to /app/dist

# Stage 2: Serve using nginx
FROM nginx:alpine

# Remove default nginx web files
RUN rm -rf /usr/share/nginx/html/*

# Copy the Vite build output
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 for production serving via Nginx
EXPOSE 80

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
