# Loading your QIIME 2 container

In this workshop, to use QIIME 2 on the command line or through Jupyter Lab, you'll work through a containerized environment.
We recommend using either [Podman](https://podman.io) or [Docker](https://docker.com).
Before you jump in with QIIME 2, follow the "Get Started" (i.e., install) instructions for one or the other, and confirm that it's working according to the Podman's or Docker's instructions.
(We don't link to their instructions here so that we don't send you to an outdated link.)

```{admonition} Podman versus Docker
:class: dropdown, question
We don't take much of a stance on this because teaching with either is still pretty new to use.
Podman definitely seems to have some interesting benefits though.
Get a perspective from the developers of Podman [here](https://www.redhat.com/en/topics/containers/what-is-podman#podman-vs-docker).
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

Take a look at the directory organization by running:

```shell
tree
```

The output should look like the following:

```shell
/home/qiime2
├── matplotlib
├── q2cli
│
```

Create a directory for your work during this workshop:

```shell
mkdir 2024-workshop
```

If you run `tree` again, you should now see the new directory:

```shell
$ tree
/home/qiime2
├── matplotlib
├── q2cli
├── 2024-workshop
```

At this point, you're ready to start working with QIIME 2.
Run the command `qiime info` to learn about the version of QIIME 2 that is installed.
You're now ready to [continue with the tutorial](exploring-the-data).
You can return to this document when you need to start, stop, or update your container.
Have fun!

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
