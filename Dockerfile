FROM golang AS builder

ENV GO111MODULE=on
ENV CGO_ENABLED=0

WORKDIR /build

# Copy the code necessary to build the application
COPY . .

# Build the application
RUN go build -o sandbox

# Create the minimal runtime image
FROM scratch

COPY --from=builder /build/sandbox /

ENTRYPOINT ["/sandbox"]
