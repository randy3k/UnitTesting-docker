# Docker image for Sublime Text UnitTesting

```sh
# cd the repo
docker build -t unittesting .
# cd to package
docker run --rm -it -e PACKAGE=$PACKAGE -v $PWD:/project unittesting 
```
