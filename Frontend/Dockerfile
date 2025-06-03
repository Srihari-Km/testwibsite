# Stage 1: Build React app with Vite
FROM node:18 AS build
WORKDIR /app

# Copy and install dependencies
COPY ./Frontend/package*.json ./
RUN npm install

# Copy source code from Frontend directory
COPY ./Frontend ./
RUN npm run build  # Vite outputs to /app/dist

# Stage 2: Serve using nginx
FROM nginx:alpine

# Clean default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy built frontend files to nginx directory
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
