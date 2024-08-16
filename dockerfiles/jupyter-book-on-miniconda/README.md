## Build the image
To build the image go to the directory containing the Dockerfile (this
directory) and run:

```shell
docker image build -t <image name> .
```

If on an M-series mac then run:

```shell
docker image build -t <image name> --platform "linux/amd64" .
```
