FROM node:22.15
WORKDIR /usr/src/apps/server
COPY package.json .
ARG NODE_ENV
RUN if [ "$NODE_ENV" = "development" ]; \
    then npm install;\
    else npm install --only=production;\
    fi
COPY . ./
ARG PORT=5080
EXPOSE $PORT
CMD [ "npm", "run", "dev:debug" ]
