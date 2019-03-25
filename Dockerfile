FROM ubuntu:16.04 as builder
LABEL maintainer="opcion2" \
      version="0.0.1" \
      stage="build" \
      description="  test multistage build"

RUN apt-get update && \
    apt-get install -y gcc && \
    mkdir /tarea2

WORKDIR /tarea2
COPY num.c /tarea2
RUN gcc -o num num.c

#-------------------------------------------------
# Stage 2 - Ejecuto el binario
#-------------------------------------------------
FROM alpine:3.6
LABEL maintainer="opcion2" \
      version="0.0.1" \
      stage="execute" \
      description="test multistage build"

RUN apk update && \
    apk add libc6-compat

COPY --from=builder /tarea2/num /bin/num
CMD ["/bin/num"]