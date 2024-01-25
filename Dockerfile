FROM node:18-alpine as build

ARG ENVIRONMENT
ENV NODE_ENV=development
ENV FRONTEND_ENV=$ENVIRONMENT

# set your working directory
WORKDIR /

ENV PATH /node_modules/.bin:$PATH

COPY package*.json ./

COPY . ./

RUN npm install -g npm@9.7.1

RUN npm i --include dev

RUN npm run build

# Use a lightweight image for the production environment
FROM nginx:1.21-alpine

# Copy the built app from the build stage to the nginx web root directory
COPY --from=build /dist /usr/share/nginx/html

# add your nginx configurations
COPY ./default.conf /etc/nginx/conf.d/default.conf

# Expose port 80 for the application
EXPOSE 80

# Start the nginx server
CMD ["nginx", "-g", "daemon off;"]