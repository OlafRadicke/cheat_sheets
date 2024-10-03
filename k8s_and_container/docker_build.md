DOCKER BUILD
============


MULTI-STAGE BUILDS
------------------

Example

```bash
FROM golang:1.23
WORKDIR /src
COPY <<EOF ./main.go
package main

import "fmt"

func main() {
  fmt.Println("hello, world")
}
EOF
RUN go build -o /bin/hello ./main.go

FROM scratch
COPY --from=0 /bin/hello /bin/hello
CMD ["/bin/hello"]
```


KNOWEN ISSUE
------------

Error picture in podman build:

```bash
 /bin/sh XXX not found
```

This can happen if you try to run a binary from another distribution on Alpine Linux.