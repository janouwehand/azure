FROM golang:1.22-alpine AS build
WORKDIR /src
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o web main.go

FROM scratch
COPY --from=build /src/web /web
EXPOSE 8080
ENTRYPOINT ["/web"]