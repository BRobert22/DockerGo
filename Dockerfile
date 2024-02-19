# syntax=docker/dockerfile:1

## Stage 1 - BUILD
FROM golang:1.22-alpine  AS build
LABEL authors="rober"

WORKDIR /app

COPY go.mod ./

RUN go mod download

COPY *.go ./

RUN go build -o /dockerGo

CMD [ "/dockerGo" ]

## Stage 2 - DEPLOY
FROM scratch

WORKDIR /

COPY --from=build /dockerGo /dockerGo

ENTRYPOINT ["/dockerGo"]