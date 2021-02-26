# Packer Docker Container

How we build packer docker images. We push these to
https://hub.docker.com/r/hashicorp/packer/ after every packer release.

Releases are tagged from the `light` version.

### Usage

This repository automatically builds containers for using the
[`packer`](https://packer.io) command line program. It contains two distinct
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
docker run <args> hashicorp/packer:light <command>
```

##### `full`

The `full` version of this container contains all of the source code found in
the parent [repository](https://github.com/hashicorp/packer). Using [Google's
official `golang` image](https://hub.docker.com/_/golang/) as a base, this
container will copy the source from the `master` branch, build the binary, and
expose it for running. Since the build is done on [Docker
Hub](https://hub.docker.com/r/hashicorp), the container is ready for use.
Because all build artifacts are included, it should be quite a bit larger than
the `light` image. This version of the container is useful for development or
debugging.

You can use this version with the following:
```shell
docker run <args> hashicorp/packer:full <command>
```

#### Running a build:

The easiest way to run a command that references a configuration with one or more template files, is to mount a volume for the local workspace.

Running `packer init`
```shell
docker run \
    -v `pwd`:/workspace -w /workspace \
    -e PACKER_PLUGIN_PATH=/workspace/.packer.d/plugins \
    hashicorp/packer:latest \
    init .
```

~> **Note**: packer init is available from Packer v1.7.0 and later

The command will mount the working directory (`pwd`) to `workspace`, which is the working directory (`-w`) inside the container. 
Any plugin installed with `packer init` will be installed under the directory specified under the `PACKER_PLUGIN_PATH` environment variable. `PACKER_PLUGIN_PATH` must be set to a path inside the volume mount so that plugins can become available at `packer build`. 

Running `packer build`
```shell
docker run \
    -v `pwd`:/workspace -w /workspace \
    -e PACKER_PLUGIN_PATH=/workspace/.packer.d/plugins \
    hashicorp/packer:latest \
    build .
```
##### Building old-legacy JSON templates

For old-legacy JSON, the build command must specify the template file(s).

```shell
docker run \
    -v `pwd`:/workspace -w /workspace \
    hashicorp/packer:latest \
    build template.json
```

For the [manual installation](https://www.packer.io/docs/plugins#installing-plugins) of third-party plugins, we recommended that plugin binaries are placed under a sub-directory under the working directory. Add `-e PACKER_PLUGIN_PATH=/workspace/<subdirectory_plugin_path>` to the command above to tell Packer where the plugins are.

To pass a var file (`var.json`) to the build command:

```shell
docker run \
    -v `pwd`:/workspace -w /workspace \
    hashicorp/packer:latest \
    build --var-file var.json template.json
```
`var.json` is expected to be inside the local working directory (`pwd`) and in the container's workspace mount.
