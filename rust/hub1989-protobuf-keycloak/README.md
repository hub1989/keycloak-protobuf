# Keycloak-protobuf
A simple lib that provides grpc API for keycloak.
You could build your own `grpc-service` or use the default service found in `github.com/hub1989/keycloak-grpc-service.

## Importing client lib into services
### Rust
```shell
cargo add hub1989-protobuf-keycloak
```

### Java
```xml
<dependency>
  <groupId>com.hub1989.keycloak</groupId>
  <artifactId>keycloak-proto</artifactId>
  <version>latest-version</version>
</dependency>
```

### Golang
```shell
go get github.com/hub1989/keycloak-protobuf/golang/keycloak@latest
```
