# Step 1: Build the app using Node
FROM node:20 as builder
WORKDIR /app

# Install dependencies
COPY Frontend/package*.json ./
RUN npm install

# Ensure Vite is executable (but this is optional if npx is used)
COPY Frontend .

# Run build using npx
RUN npx --yes vite build

# Step 2: Serve the app using Nginx
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
