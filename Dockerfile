FROM alpine:3.8

ARG VCS_REF
ARG BUILD_DATE
ARG VERSION

LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/apihackers/docker-ansible-lint" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

COPY requirements.pip /tmp/requirements.pip

RUN apk add --no-cache python3 && \
    apk add --no-cache --virtual .build-deps build-base python3-dev libffi-dev openssl-dev && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip && \
    pip3 install -r /tmp/requirements.pip && \
    apk del .build-deps && \
    rm -r /root/.cache

# FROM python:3.6-alpine

# COPY requirements.pip /tmp/requirements.pip

# RUN pip3 install -U pip \
#     && pip3 install -r /tmp/requirements.pip \
#     && rm -r /root/.cache

# RUN apk add --no-cache openssh git curl python3 ca-certificates gzip && \
#     python3 -m ensurepip && \
#     rm -r /usr/lib/python*/ensurepip && \
#     pip3 install -r /tmp/requirements.pip && \
#     rm -r /root/.cache

# ENTRYPOINT ["twine"]
# CMD [ "ansible-playbook" ]

ENV WORKSPACE /workspace

RUN mkdir $WORKSPACE

VOLUME $WORKSPACE

WORKDIR $WORKSPACE

ENTRYPOINT [ "ansible-lint" ]
