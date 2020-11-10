FROM docker.pkg.github.com/yjgbg/builder/356303389:master as builder
COPY ./ /target/
WORKDIR /target/
RUN flutter create .
RUN flutter build web

FROM nginx:alpine
COPY --from=builder /target/build/web/ /usr/share/nginx/html/