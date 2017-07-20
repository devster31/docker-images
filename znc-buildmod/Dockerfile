FROM linuxserver/znc

RUN apk --no-cache --update add \
      curl \
      curl-dev \
      g++ \
      git \
      icu-dev \
      libressl-dev \
      make \
      zlib-dev

RUN git clone https://github.com/jreese/znc-push.git /opt/znc-push
WORKDIR /opt/znc-push
ENV CFLAGS=" -static"
RUN make curl=yes && \
    cp /opt/znc-push/push.so /config/modules/push.so
