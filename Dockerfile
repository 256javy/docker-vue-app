# Dockerfile for vue3 with nginx and stages

# Stage 1 - the build process
FROM node:lts-alpine as build-stage

# Create app directory
WORKDIR /app

# Install app dependencies
COPY package*.json ./

RUN npm install

# Bundle app source
COPY . .    

RUN npm run build

# Stage 2 - the production environment
FROM nginx:stable-alpine as production-stage

# Copy the dist folder from the build stage
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Expose the port the app runs in
EXPOSE 80

# Serve the app
CMD ["nginx", "-g", "daemon off;"]

# Build the image
# docker build -t docker-vue-app .

# Run the container
# docker run -d -p 8080:80 --name docker-vue-app docker-vue-app