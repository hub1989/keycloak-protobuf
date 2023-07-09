use grpc_build::Builder;

fn main() {
    Builder::new()
        .build_server(true)
        .build_client(true)
        .force(true)
        .out_dir("src/protogen")
        .build("protos")
        .unwrap();
}
