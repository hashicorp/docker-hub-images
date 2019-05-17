# terraform Docker Container

How we build terraform docker images. We push these to
https://hub.docker.com/r/hashicorp/terraform/ after every terraform release.

Releases are tagged from the `light` version.

### Usage

This repository automatically builds containers for using the
[`terraform`](https://terraform.io) command line program. It contains two distinct
varieties of build, a `light` version, which just contains the binary, and
a `full` version while compiles the binary from source inside the container
before exposing it for use. Which you want will depend on use.

##### `light` (default)

The `light` version of this container will copy the current stable version of
the binary into the container, and set it for use as the default entrypoint.
This will be the best option for most uses, and if you are just looking to run
the binary from a container. The `latest` tag also points to this version.

You can use this version with the following:
```shell
docker run -i -t hashicorp/terraform:light <command>
```

##### `full`

The `full` version of this container contains all of the source code found in
the parent [repository](https://github.com/hashicorp/terraform). Using [Google's
official `golang` image](https://hub.docker.com/_/golang/) as a base, this
container will copy the source from the `master` branch, build the binary, and
expose it for running. Since the build is done on [Docker
Hub](https://hub.docker.com/r/hashicorp), the container is ready for use.
Because all build artifacts are included, it should be quite a bit larger than
the `light` image. This version of the container is useful for development or
debugging.

You can use this version with the following:
```shell
docker run -i -t hashicorp/terraform:full <command>
```
