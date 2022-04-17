# docker-grpc_cli
grpc_cli Docker container on armv8

----
Based on [hatena/docker\-grpc\_cli: grpc\_cli Docker Image](https://github.com/hatena/docker-grpc_cli)


## How to build a container

```
$ sudo docker build -t grpc_cli .
```


## How to run grpc_cli
```
$ sudo docker run --rm grpc_cli:latest ls <YOUR_SERVER> -l
```
