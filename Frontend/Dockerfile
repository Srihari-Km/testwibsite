# Stage 1: Build React app with Vite
FROM node:18 AS build
WORKDIR /app

# Set NODE_ENV to development to make sure devDependencies are installed
ENV NODE_ENV=development

# Copy package.json and package-lock.json for stable installs
COPY package*.json ./

# Install dependencies including devDependencies
RUN npm ci

# Copy the rest of the source code
COPY . .

# Build the React app with Vite
RUN npm run build

# Stage 2: Serve using nginx
FROM nginx:alpine

# Clean default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy built frontend files to nginx directory
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]
