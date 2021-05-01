FROM buildpack-deps:buster as builder

RUN apt-get update && apt-get install -y \
    wget \
    libgflags-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget -q -O bazel https://github.com/bazelbuild/bazel/releases/download/4.0.0/bazel-4.0.0-linux-arm64 && \
    chmod +x bazel && mv bazel /usr/local/bin/

ENV CC=/usr/bin/gcc

ARG GRPC_VERSION="v1.37.1"
RUN git clone -b $GRPC_VERSION https://github.com/grpc/grpc \
    && cd grpc \
    && git submodule update --init \
    && bazel build //test/cpp/util:grpc_cli

FROM debian:buster-slim

COPY --from=builder /grpc/bazel-bin/test/cpp/util/grpc_cli /usr/local/bin/grpc_cli

ENTRYPOINT ["grpc_cli"]
