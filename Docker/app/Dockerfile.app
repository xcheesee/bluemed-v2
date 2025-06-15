FROM node:22-alpine as base

WORKDIR /home/app

COPY package*.json ./

RUN npm i

COPY . .

FROM base as production

#ENV NODE_PATH=./build

RUN npm run build

FROM nginx:1.28.0-alpine

WORKDIR /home/app

COPY --from=production /home/app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]