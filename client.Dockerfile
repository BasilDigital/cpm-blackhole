FROM node:alpine AS build-stage
WORKDIR /usr/src/apps/cpm-client
COPY package*.json .
ARG EXPO_PUBLIC_BASE_URL
ENV EXPO_PUBLIC_BASE_URL=$EXPO_PUBLIC_BASE_URL
RUN  npm install;
COPY . ./
RUN npm i --unsafe-perm --allow-root -g npm@latest expo-cli@latest
RUN npx expo export -p web

FROM nginx:stable-alpine
COPY --from=build-stage /usr/src/apps/cpm-client/dist /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY --from=nginx nginx.conf /etc/nginx/conf.d
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
