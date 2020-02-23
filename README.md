# How to use this container

```
docker run --volume="$PWD:/root/project:delegated" --port 4000:4000 -ti mrseccubus:github-pages
```
This runs a Jekyll server ala Github pages locally. Input is take from the current directory and output is put in `_site`

# How to run different commands

Any argument provided to the docker container will be added to the Jekyll command. e.g.

```
docker run --volume="$PWD:/root/project:delegated"  -ti mrseccubus:github-pages build
```

Will just build the site in `./_site` and quit.