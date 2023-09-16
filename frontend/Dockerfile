FROM oven/bun:1.0 AS builder

WORKDIR /app

ARG ENVIRONMENT

ENV NODE_ENV=${ENVIRONMENT}

COPY package*.json ./

COPY . .

RUN bun install

EXPOSE 3000

CMD ["bun", "run", "start"]
