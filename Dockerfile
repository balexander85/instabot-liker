FROM python:3.7-slim-buster

ARG geckodriver_ver=0.23.0
WORKDIR /code/

COPY docker_quickstart.py /code/
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends --no-install-suggests \
            ca-certificates \
 && update-ca-certificates \
 # Install tools for building
 && toolDeps=" \
        curl bzip2 \
    " \
 && apt-get install -y --no-install-recommends --no-install-suggests \
            $toolDeps \
 # Download geckodriver source and build
 && curl -fL -o /tmp/geckodriver.tar.gz \
         https://github.com/mozilla/geckodriver/releases/download/v${geckodriver_ver}/geckodriver-v${geckodriver_ver}-arm7hf.tar.gz \
 && tar -xzf /tmp/geckodriver.tar.gz -C /tmp/ \
 && chmod +x /tmp/geckodriver \
 && mv /tmp/geckodriver /usr/local/bin/ \
    \
 # Install packages
 && apt-get install -y --no-install-recommends --no-install-suggests \
         firefox-esr \
         build-essential \
         libssl-dev \
         libffi-dev \
         python3-dev \
         wget \
         gcc \
         g++ \
 && pip install instapy==0.6.8 \
 # Cleanup unnecessary stuff
 && apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
            $toolDeps \
 && rm -rf /var/lib/apt/lists/* \
           /tmp/*

CMD ["python", "docker_quickstart.py"]

