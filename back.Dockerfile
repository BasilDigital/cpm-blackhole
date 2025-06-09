FROM node:22.15
WORKDIR /usr/src/apps/server
COPY package.json .
ARG NODE_ENV
RUN  npm install;
COPY . ./
ARG PORT=5080
EXPOSE $PORT
CMD [ "npm", "run", "start" ]
