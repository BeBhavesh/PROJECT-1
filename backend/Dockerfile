# base image
FROM node:18-alpine

# app directory
WORKDIR /app

# package files copy
COPY package*.json ./

#Install dependancies
RUN npm install --production

#App code only
COPY . .

# EXPOSE port
EXPOSE 3000

# START app
CMD [ "node", "app.js" ]
