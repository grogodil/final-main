FROM golang:1.22 AS builder

WORKDIR /app

COPY . .

RUN go mod download 

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /app/my_app

FROM alpine:latest

COPY --from=builder /app/my_app /app/tracker.db /app/

CMD cd /app && ./my_app 