# README

## Deployment instructions

Build the docker image:
```sh
$ docker-compose build
```
Compile assets:

```sh
$ docker-compose run -it app rails assets:precompile
```
Start the service:
```sh
$ docker-compose run -d
```
