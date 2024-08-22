# Setting Up Docker

## Pulling the Docker Image
First we need to pull (download) the image that contains our qiime2
environment.
```shell
docker image pull quay.io/qiime2/workshops:2024.08.27-nih-amplicon-2024.5
```


``````{admonition} Building the image locally
:class: dropdown

```{warning}
Only use this approach if you have a good reason to do so, e.g. if you
want to experiment with changes to the Dockerfile. Otherwise, pulling the
image will be quicker and easier.
```

We can build the image ourselves by doing the following.

We clone the repository for this Jupyter book.
```shell
git clone git@github.com:caporaso-lab/2024-q2-ITN-Workshop.git
```

We navigate to the directory that contains the Dockerfile and auxiliary data.
```shell
cd 2024-q2-ITN-Workshop/dockerfiles/jupyter-lab-on-miniconda
```

First we make sure that the Docker daemon is running (e.g. by launching Docker
Desktop). Then we build the image.
`````{tab-set}
````{tab-item} Standard Instructions
```shell
docker image build -t <my-image-name> .
```
````
````{tab-item} M-series Mac Instructions
```shell
docker image build -t <my-image-name> --platform "linux/amd64" .
```
````
`````

``````

Next, we create a volume that will be used to store any data we generate during
our analysis.
```shell
docker volume create qiime2-workshop
```

Now we'll start the container.

`````{tab-set}
````{tab-item} Standard Instructions
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

````{tab-item} M-series Mac Instructions
```shell
docker container run \
  -itd \
  --rm \
  -v qiime2-workshop:/home/qiime2 \
  --name workshop \
  -p 8889:8888 \
  --platform "linux/amd64" \
  quay.io/qiime2/workshops:2024.08.27-nih-amplicon-2024.5
```
````
`````


Now that the container is running, we can interact with it in the browser by
going to the following url.
```shell
http://localhost:8889
```

````{note}
If you ever need to stop the container you can do so through Docker Desktop or
through the CLI as follows.

```shell
docker container stop qiime2-workshop
```

Any data that you created in the container will persist in the volume and be
available the next time you start the container.
````

```{note}
Once you're done using the QIIME2 Docker container, and if you have no other
running containers, it's a good idea to quit Docker to free up system
resources.
```

## File Organization
Let's take a look at our directory organization
```shell
tree
```
This is what it should look like.
```shell
/home/qiime2
├── matplotlib
├── q2cli
│
```

Now lets make a directory for us to run our analysis in!

```shell
mkdir 2024-workshop
```

```shell
tree
```

```shell
/home/qiime2
├── matplotlib
├── q2cli
├── 2024-workshop
```
