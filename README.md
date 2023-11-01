# Ubuntu ROCK for Boinc

[This image](https://github.com/cjdcordeiro/boinc-client-rock) is a Jammy-based
ROCK comprising the [Boinc](https://boinc.berkeley.edu/) client and additional
GPU dependencies.

By default, the client will run and attach itself to a remote Account Manager,
according to the provided connection and authentication arguments.

## Build

To build this image, you'll need Rockcraft:

```bash
snap install --classic rockcraft
```

Then, from the same directory as the `rockcraft.yaml`
[file](https://github.com/cjdcordeiro/boinc-client-rock/blob/main/rockcraft.yaml),
run:

```bash
rockcraft pack -v
```

The end result will be a `.rock` file (in the form of an OCI archive) that you
must import into the Docker daemon, with something like
[Skopeo](https://github.com/containers/skopeo). For example:

```bash
skopeo copy oci-archive:boinc-client_latest_amd64.rock docker-daemon:cjdcordeiro/boinc-client:latest
```

## Deploy

To deploy this Boinc ROCK, you'll first need to register with an
[Account Manager](https://boinc.berkeley.edu/wiki/Account_managers).

Using [BAM!](https://www.boincstats.com/bam/) as an example, you'll need to
start by exporting the following variables:

```bash
ACCOUNT_MANAGER_URL='http://bam.boincstats.com'
USERNAME=<you-bam-username>
read -s PASSWORD
# <your-bam-password>
```

Then, you can run the ROCK via:

```bash
docker run --device /dev/dri:/dev/dri \
    -e PASSWORD=$PASSWORD \
    -e USERNAME=$USERNAME \
    -e ACCOUNT_MANAGER_URL=$ACCOUNT_MANAGER_URL \
    cjdcordeiro/boinc-client
```

Feel free to play with the following Docker options:

- `--device`: if you want to add additional drivers to support the projects you
are volunteering to;
- `-h`: to fix the name of the worker that will appear associated with the Boinc
projects;

**Once the container is running**, it will run the CPU benchmarks and attach
itself to the Account Manager. From there on, you can manage which projects to
connect to and which tasks to run (and how to run them), from the Account Manager
portal directly.
