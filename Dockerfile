FROM docker.pkg.github.com/yjgbg/builder/master:356192827 as builder
COPY ./ /target/
WORKDIR /target/
RUN flutter build web

FROM nginx:alpine
COPY --from=builder /target/build/web/ /usr/share/nginx/html/