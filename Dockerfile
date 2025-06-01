# Step 1: Build the app using Node
FROM node:20 as builder
WORKDIR /app
COPY Frontend/package*.json ./
RUN npm install
COPY Frontend ./
RUN npm run build

# Step 2: Serve the app using Nginx
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
