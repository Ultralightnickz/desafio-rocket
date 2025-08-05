FROM python:3.9.23-alpine AS build

RUN apk add --no-cache build-base postgresql-dev libc6-compat linux-headers libffi-dev openssl-dev bash

WORKDIR /app

COPY app/requirements.txt .

RUN pip install --upgrade pip && pip install -r requirements.txt

FROM python:3.9.23-alpine

RUN apk add --no-cache libc6-compat postgresql-libs

WORKDIR /app

COPY --from=build /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY app/ .

CMD ["python", "main.py"]

