FROM resin/raspberrypi3-alpine

RUN apk add --update \
       ca-certificates \
       git \
       python \
       py-pip \
    && rm -rf /var/cache/apk/*

RUN git clone https://github.com/Flexget/Flexget.git /flexget
WORKDIR /flexget

RUN pip install paver
RUN pip install -e .

RUN mkdir /root/.flexget
VOLUME /root/.flexget

CMD ["flexget"]
