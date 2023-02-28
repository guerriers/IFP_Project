# Taken from https://nodejs.org/en/docs/guides/nodejs-docker-webapp/
FROM node:12.20.0-alpine3.10

# create destination directory
RUN mkdir -p /usr/src/backend-app
WORKDIR /usr/src/backend-app

# update and install dependency
RUN apk update && apk upgrade
RUN apk add git

# copy the app, note .dockerignore
COPY . /usr/src/backend-app/
RUN npm install
RUN npm run build

EXPOSE 8080

ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=8080

CMD [ "npm", "start" ]
