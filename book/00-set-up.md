# Setting Up Docker

## Pulling the Docker Image
First we need to pull (download) the image that contains our qiime2
environment.
```shell
docker image pull <TODO>
```

Next, we create a volume that will be used to store any data we generate during
our analysis.
```shell
docker volume create qiime2-workshop
```

Now we'll start the container.
```shell
docker container run \
    -itd \
    --rm \
    -v qiime2-workshop:/home/qiime2 \
    --name workshop \
    -p 8889:8888 \
    <TODO - name of image>
```

If you're using an M-series Mac then add the following option to the above
command.
```shell
--platform "linux/amd64"
```

Now that the container is running, we can interact with it in the browser by
going to the following url.
```shell
localhost:8889
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
