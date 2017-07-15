FROM lsiobase/xenial

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update -q && \
    apt install -y --no-install-recommends \
      g++ \
      gcc \
      git \
      libboost-dev \
      libcurl4-openssl-dev \
      libev-dev \
      libffi-dev \
      libssl-dev \
      python-dev \
      python \
      python-imaging \
      rhino \
      tesseract-ocr \
      unrar

RUN mkdir /app && cd /app && \
    git clone https://github.com/pyload/pyload -b stable && \
    python -m ensurepip --upgrade && \
    pip --no-cache install -U setuptools wheel && \
    pip --no-cache install \
      Beaker \
      bjoern \
      # BeautifulSoup \
      # colorama \
      # feedparser \
      # jinja2 \
      # Pillow \
      pycurl \
      pycrypto \
      pyOpenSSL
      # pyv8 \
      # Spidermonkey \
      # thrift

WORKDIR /app
EXPOSE 8000
VOLUME /config /downloads
