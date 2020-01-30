FROM node:12.14.1-alpine3.11

# Install Cryptpad from the GitHub repo, master branch
# DL3016: Pin versions in npm. This is done in cryptpad
# DL3003: The parsing logic seems broken
# hadolint ignore=DL3016,DL3003
RUN true \
   && apk add --no-cache wget=1.20.3-r0 git=2.24.1-r0 \
   && wget https://github.com/xwiki-labs/cryptpad/archive/3.10.0.tar.gz \
   && tar xzf 3.10.0.tar.gz \
   && rm 3.10.0.tar.gz \
   && mv cryptpad-3.10.0 cryptpad \
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
