FROM yjgbg/flutter-web-builder:latest as builder
COPY ./ /target/
WORKDIR /target/
RUN flutter create .
RUN flutter build web

FROM nginx:alpine
COPY --from=builder /target/build/web/ /usr/share/nginx/html/