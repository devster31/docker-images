FROM resin/raspberrypi3-alpine

ENV VMARGS -Dbliss_working_directory=/config

VOLUME /config

EXPOSE 3220 3221

RUN mkdir /bliss

ADD bliss-runner.sh /bliss/

RUN chmod +x /bliss/bliss-runner.sh

RUN apk add --update \
       wget \
       openjdk7-jre \
    && rm -rf /var/cache/apk/*

RUN wget -qO- http://www.blisshq.com/app/latest-linux-version | xargs wget -O bliss-install-latest.jar -nv

RUN echo INSTALL_PATH=/bliss > auto-install.properties
RUN java -jar bliss-install-latest.jar -console -options auto-install.properties

WORKDIR /bliss

CMD /bliss/bliss-runner.sh
