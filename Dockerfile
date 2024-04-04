# Stage 1
FROM node:20.11.1-alpine3.18  as node


RUN mkdir -p /usr/local/app


WORKDIR /usr/local/app


COPY . /usr/local/app


RUN npm ci


RUN npm run build:prod


# Stage 2
FROM nginx:1.25.4-alpine

COPY --from=node /usr/local/app/dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/

RUN chmod -R 777 /var/cache/nginx && \
    chmod -R 777 /var/log/nginx


RUN touch /var/run/nginx.pid && \
    chmod -R 777 /var/run/nginx.pid

EXPOSE 8000