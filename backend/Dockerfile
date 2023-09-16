FROM --platform=$BUILDPLATFORM golang:1.19-buster as builder

WORKDIR /go/src/github.com/quickchat/app

COPY go.* .

RUN go mod download

COPY . .

ARG TARGETOS TARGETARCH

RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o app main.go

FROM alpine:3.16.0

RUN apk --no-cache add ca-certificates

COPY --from=builder /go/src/github.com/quickchat/app .

CMD [ "./app" ]
