# README

## Deployment instructions

Build the docker image:
```sh
$ docker-compose build
```
Compile assets and setup the database:

```sh
$ docker-compose run app rails assets:precompile
$ docker-compose run app rails db:prepare
```
Start the service:
```sh
$ docker-compose up -d
```
