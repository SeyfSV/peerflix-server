FROM node:12-alpine

# Update latest available packages,
# add 'app' user, and make temp directory
RUN apk --no-cache add ffmpeg git && \
    npm install -g grunt-cli bower

RUN mkdir /tmp/torrent-stream && \
    mkdir -p /app/config && \
    mkdir -p .config && \
    chmod 777 /tmp/torrent-stream && \
    touch /start.sh && \
    echo ln -s /app/config ~/.config/peerflix-server > /start.sh && \
    echo npm start >> /start.sh && \
    chmod +x /start.sh

WORKDIR /app
COPY . .

RUN npm install && \
    bower --allow-root install && \
    grunt build

VOLUME [ "/tmp/torrent-stream" ]
VOLUME [ "/app/config" ]
EXPOSE 6881 9000

CMD [ "/start.sh" ]
