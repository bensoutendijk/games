FROM node:18-alpine3.15 as dev

WORKDIR /app

COPY ./frontend .

RUN npm ci

CMD npm run dev

FROM node:18-alpine3.15 AS build

WORKDIR /app

COPY ./frontend .

RUN npm ci
RUN npm run build

FROM caddy:2.5.1-alpine as prod

COPY --from=build /app/dist/ /usr/share/caddy/
