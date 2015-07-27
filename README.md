# docker-komstik
Docker container to test komstik

## How to build
```
git clone https://github.com/geonux/docker-komstik.git
cd docker-komstik
docker build -t komstik .
```

## How to launch
```
docker run -p 6789:6789 -t -i komstik
```
