FROM golang:1.22 AS builder
WORKDIR /src
COPY . .
RUN go build -o /out/app ./cmd/app

FROM gcr.io/distroless/static AS runtime
COPY --from=builder /out/app /app
ENTRYPOINT ["/app"]
