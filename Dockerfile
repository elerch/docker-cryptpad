FROM node:12.14.1-alpine3.11

ARG VERSION=3.10.0
# Install Cryptpad from the GitHub repo, master branch
# DL3016: Pin versions in npm. This is done in cryptpad
# DL3003: The parsing logic seems broken
# hadolint ignore=DL3016,DL3003
RUN true \
   && apk add --no-cache wget=1.20.3-r0 git=2.24.1-r0 \
   && wget -q -O cryptpad.tar.gz https://github.com/xwiki-labs/cryptpad/archive/${VERSION}.tar.gz \
   && tar xzf cryptpad.tar.gz \
   && rm cryptpad.tar.gz \
   && mv cryptpad-${VERSION} cryptpad \
   && npm install --prefix /cryptpad cryptpad/ \
   && npm install -g bower@1.8.8 \
   && (cd cryptpad &&  bower install --allow-root) \
   && npm remove -g bower \
   && apk del wget git

# Copies the config.js, with logging to stdout set to true
COPY config.js /cryptpad/config/

WORKDIR /cryptpad

EXPOSE 3000

ENTRYPOINT ["node"]
CMD ["./server.js"]
