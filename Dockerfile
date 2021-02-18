FROM --platform=${TARGETPLATFORM:-linux/amd64} python:2.7-alpine3.10
ARG TARGETPLATFORM
ARG BUILDPLATFORM

LABEL maintainer="CrazyMax"

ENV SYNCSERVER_VERSION="1.9.1" \
  SHA1_COMMIT="040d642d5740f80cd54fb22fda5ea75296f7c50c" \
  TZ="UTC" \
  PUID="1000" \
  PGID="1000"

RUN apk --update --no-cache add \
    bash \
    curl \
    libffi \
    libressl \
    libstdc++ \
    mariadb-client \
    postgresql-client \
    shadow \
    su-exec \
    tzdata \
  && apk --update --no-cache add -t build-dependencies \
    build-base \
    gcc \
    git \
    libffi-dev \
    libressl-dev \
    mariadb-dev \
    musl-dev \
    postgresql-dev \
    python-dev \
  && git clone https://github.com/mozilla-services/syncserver app \
  && cd app \
  && git reset --hard $SHA1_COMMIT \
  && pip install --upgrade --no-cache-dir -r requirements.txt \
  && pip install --upgrade --no-cache-dir -r dev-requirements.txt \
  && pip install psycopg2 pymysql \
  && apk del build-dependencies \
  && rm -rf /tmp/* /var/cache/apk/* \
  && python ./setup.py develop

COPY entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh \
  && mkdir -p /data /opt/syncserver \
  && addgroup -g ${PGID} syncserver \
  && adduser -u ${PUID} -G syncserver -h /data -s /bin/sh -D syncserver \
  && chown -R syncserver. /data /opt/syncserver

EXPOSE 5000
VOLUME [ "/data" ]

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/usr/local/bin/gunicorn", "--paste", "/opt/syncserver/syncserver.ini" ]
