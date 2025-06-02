# Step 1: Build the app using Node
FROM node:20 as builder
WORKDIR /app

# Copy only package files and install dependencies
COPY Frontend/package*.json ./
RUN npm install

# Copy rest of the frontend code
COPY Frontend .

# Build the app
RUN npx --yes vite build

# Step 2: Serve the app using Nginx
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
