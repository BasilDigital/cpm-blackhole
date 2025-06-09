FROM node:alpine AS build-stage
WORKDIR /usr/src/apps/cpm-client
COPY package*.json .
ARG NODE_ENV
RUN if [ "$NODE_ENV" = "development" ]; \
    then npm install;\
    else npm install;\
    fi
COPY . ./
RUN npm i --unsafe-perm --allow-root -g npm@latest expo-cli@latest
RUN npx expo export -p web

FROM nginx:stable-alpine
COPY --from=build-stage /usr/src/apps/cpm-client/dist /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/conf.d
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
