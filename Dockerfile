# syntax=docker/dockerfile:1.2

FROM alpine AS download

WORKDIR /app

RUN apk add --no-cache openssh-client git

RUN mkdir -p -m 0700 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

RUN --mount=type=ssh,id=key,required git clone git@github.com:Kamiliush/Docker-Lab-Repo.git Simpleweb

FROM node:alpine

COPY --from=download /app/Simpleweb /app

WORKDIR /app/Simpleweb

RUN npm install

EXPOSE 8080

CMD ["npm", "start"]