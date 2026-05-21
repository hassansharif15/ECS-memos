FROM node:22-alpine AS frontend

WORKDIR /app/web

RUN corepack enable && corepack prepare pnpm@10.27.0 --activate

COPY web/package.json web/pnpm-lock.yaml* ./
RUN pnpm install

COPY web/ ./
RUN pnpm release


FROM golang:1.26.2-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
COPY --from=frontend /app/web ./web

RUN mkdir -p build && go build -o build/memos ./cmd/memos


FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/build/memos ./memos

RUN addgroup -S memos && adduser -S memos -G memos \
    && mkdir -p /var/opt/memos \
    && chown -R memos:memos /var/opt/memos /app

USER memos

EXPOSE 8081

VOLUME ["/var/opt/memos"]

CMD ["./memos", "--data", "/var/opt/memos"]