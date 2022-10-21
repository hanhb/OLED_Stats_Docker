# syntax = docker/dockerfile:1.2

FROM python:alpine

ENV VIRTUAL_ENV=/opt/venv

RUN python -m venv $VIRTUAL_ENV

ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN apk add --no-cache i2c-tools libgpiod-dev gcc libc-dev linux-headers py3-pillow procps zlib-dev jpeg-dev freetype-dev

WORKDIR /opt/stats

COPY PixelOperator.ttf lineawesome-webfont.ttf stats.py requirements.txt ina219.py /opt/stats/

RUN --mount=type=cache,mode=0755,target=/root/.cache/pip pip install -r requirements.txt 

ENTRYPOINT [ "python", "stats.py" ]
