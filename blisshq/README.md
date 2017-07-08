# BlissHQ

Tutorial originally written here: [Installing bliss in a QNAP Docker container](https://www.blisshq.com/music-library-management-blog/2015/12/01/installing-bliss-qnap-docker-container-station/)

Their latest [Dockerfile](https://www.blisshq.com/downloads/blog/installing-bliss-qnap-docker-container/Dockerfile) and their latest [runner](https://www.blisshq.com/downloads/blog/installing-bliss-qnap-docker-container/bliss-runner.sh).

Instructions:
```sh
docker build --rm=true --tag="blisshq" .
docker run -d --name=blisshq -p 3220:3220 -p 3221:3221 blisshq
```
