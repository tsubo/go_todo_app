FROM golang:1.21.5-bullseye as deploy-builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go guild -trimpath -ldflags "-w -s" -o app

# -----------------------------------------------

# デプロイ用のコンテナ
FROM debian:bullseye-slim as deploy

RUN apt-get update

COPY --from=deploy-builder /app/app .

CMD ["./app"]

# -----------------------------------------------

# ローカル環境で利用するホットリロード環境
FROM golang:1.21.5 as dev
WORKDIR /app
RUN go install github.com/cosmtrek/air@latest
CMD ["air"]
