FROM node:18

WORKDIR /app

# Copy only package.json and package-lock.json for caching
COPY package*.json ./

# Install dependencies inside container fresh
RUN npm install

# Copy rest of the source files
COPY . .

# Build the project
RUN npm run build
