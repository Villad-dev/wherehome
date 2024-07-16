FROM debian:latest AS build-env

RUN apt-get update 
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libglu1-mesa fonts-droid-fallback python3
RUN apt-get clean

RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web

RUN mkdir /app/
COPY . /app/
WORKDIR /app/
RUN flutter build web --dart-define=BACK_API=http://localhost:8080

FROM nginx:1.21.1-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /data/conf/nginx.conf
COPY --from=build-env /app/build/web /usr/share/nginx/html