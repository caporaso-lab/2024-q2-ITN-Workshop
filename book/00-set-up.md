# Working with your QIIME 2 container

In this workshop, to use QIIME 2 on the command line or through Jupyter Lab, you'll work through a containerized environment.
We recommend using either [Podman](https://podman.io) or [Docker](https://docker.com).
Before you jump in with QIIME 2, follow the "Get Started" (i.e., install) instructions for one or the other, and confirm that it's working according to the Podman's or Docker's instructions.
(We don't link to their instructions here so that we don't send you to an outdated link.)

```{admonition} Podman versus Docker
:class: dropdown, question
We don't take much of a stance on whether Podman or Docker is a better tool for using QIIME 2 - teaching with either is still pretty new to us.

Podman seems to have some interesting benefits though, including ease of transition to paid cloud environments (via [Kubernetes](https://www.digitalocean.com/products/kubernetes)) if you need more computational resources than you have access to.
Podman also doesn't require that you have root/admin access on the computer where you're using it, so may work better if you're using computer hardware that is administered by others (such as a laptop computer owned and maintained by your employer).

You can find a perspective on the differences between the two from the developers of Podman [here](https://www.redhat.com/en/topics/containers/what-is-podman#podman-vs-docker).
```

(pull-image)=
## Pull the container image

After installing Docker or Podman, we next need to pull (i.e., download) the image that contains our QIIME 2 environment.
Copy/paste the relevant commands.

`````{tab-set}
````{tab-item} Docker instructions
```shell
docker \
 image \
 pull quay.io/qiime2/workshops:2024.08.27-nih-amplicon-2024.5
```
````

````{tab-item} Podman instructions
```shell
podman \
 image \
 pull quay.io/qiime2/workshops:2024.08.27-nih-amplicon-2024.5
```
````
`````

(create-volume)=
## Create data storage volume

Next, we create a volume that will be used to store any data we generate during our analysis.
Data that you create in your container will persist and be available the next time you start the container.

`````{tab-set}
````{tab-item} Docker
```shell
docker volume create qiime2-workshop
```
````
````{tab-item} Podman
```shell
podman volume create qiime2-workshop
```
````
`````

(start-container)=
## Start the container

Next, we'll start the container.

`````{tab-set}

````{tab-item} Docker
```shell
docker container run \
  -itd \
  --rm \
  -v qiime2-workshop:/home/qiime2 \
  --name qiime2-workshop \
  -p 8889:8888 \
  quay.io/qiime2/workshops:2024.08.27-nih-amplicon-2024.5
```
````

````{tab-item} Docker on Apple M-series
```shell
docker container run \
  -itd \
  --rm \
  -v qiime2-workshop:/home/qiime2 \
  --name qiime2-workshop \
  -p 8889:8888 \
  --platform "linux/amd64" \
  quay.io/qiime2/workshops:2024.08.27-nih-amplicon-2024.5
```
````

````{tab-item} Podman
```shell
podman container run \
  -itd \
  --rm \
  -v qiime2-workshop:/home/qiime2 \
  --name qiime2-workshop \
  -p 8889:8888 \
  quay.io/qiime2/workshops:2024.08.27-nih-amplicon-2024.5
```
````

````{tab-item} Podman on Apple M-series
```shell
podman container run \
  -itd \
  --rm \
  -v qiime2-workshop:/home/qiime2 \
  --name qiime2-workshop \
  -p 8889:8888 \
  --platform "linux/amd64" \
  quay.io/qiime2/workshops:2024.08.27-nih-amplicon-2024.5
```
````
`````

## Interact with Jupyter Lab and QIIME 2

When the container is running, you can interact with it by opening the following link: http://localhost:8889

### Using QIIME 2 through the command line

In the Jupyter Lab window, click the *Terminal* button toward the bottom right.
(Look for a block box with a `$` symbol in it.)

You'll then have command line access to QIIME 2.

In the terminal environment, run the following command:

```shell
qiime info
```

This provides information on your QIIME 2 environment, including the versions of the QIIME 2 framework, Python, and the installed plugins.

To get a start getting a feel for what you can do with your QIIME 2 deployment, run:

```shell
qiime --help
```

This provides a list of the available QIIME 2 plugins.
To learn more about what you can do with one of them (for example, the `feature-table` plugin), call:

```shell
qiime feature-table --help
```

This will display a list of actions (i.e., commands) that are available in that plugin.
To learn how to use one, for example `filter-samples`, call:

```shell
qiime feature-table filter-samples --help
```

That will provide help text and a list of examples that illustrate how to use the command to achieve different goals.

You can return to this document when you need to start, stop, or update your container.
You can now continue to [](exploring-the-data-container).

## Stopping the container

When you're no longer using the container, you can stop it as follows:

`````{tab-set}
````{tab-item} Docker
```shell
docker container stop qiime2-workshop
```
````

````{tab-item} Podman
```shell
podman container stop qiime2-workshop
```
````
`````

If using Docker, once you're done using your container and don't have any other containers running, it's a good idea to quit Docker so it's not using resources unnecessarily.

(build-the-image)=
## Building the image locally (optional; experts only ♦♦)

**Expert users** may ultimately be interesting in modifying the image used here.
This can be done with `docker` as follows.
[Pulling the image](pull-image) will be quicker and easier.

First, clone the repository for this Jupyter book.
```shell
git clone git@github.com:caporaso-lab/2024-q2-ITN-Workshop.git
```

Then, navigate to the directory that contains the Dockerfile and auxiliary data.

```shell
cd 2024-q2-ITN-Workshop/dockerfiles/jupyter-lab-on-miniconda
```

Next, make sure that the Docker daemon is running (e.g. by launching Docker Desktop).

Finally, build the image.

`````{tab-set}
````{tab-item} Standard Instructions
```shell
docker image build -t my-image-name .
```
````
````{tab-item} M-series Mac Instructions
```shell
docker image build -t my-image-name --platform "linux/amd64" .
```
````
`````
