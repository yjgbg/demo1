FROM ubuntu as builder
# Prerequisites
RUN apt-get update && apt-get install -y unzip xz-utils git openssh-client curl && apt-get upgrade -y && rm -rf /var/cache/apt
# Install flutter beta
RUN curl -L https://storage.googleapis.com/flutter_infra/releases/beta/linux/flutter_linux_1.22.0-12.1.pre-beta.tar.xz | tar -C /opt -xJ
ENV PATH "$PATH:/opt/flutter/bin"
# Enable web capabilities
RUN flutter config --enable-web
RUN flutter upgrade
RUN flutter pub global activate webdev
RUN flutter doctor
RUN flutter build web

FROM nginx
COPY --from=builder build/web/ /usr/share/nginx/html/