FROM riceball/tts:zh-1.0.0
LABEL maintainer="Riceball LEE <snowyu.lee@gmail.com>"

ENV LANG C.UTF-8

USER root
RUN if [ -f /data/options.json ]; then \
        cp /data/options.json /home/tts/options.json; \
    fi

USER tts

ENV CONFIG_PATH /home/tts/options.json

COPY run.sh /home/tts/run.sh

ENTRYPOINT ["/home/tts/run.sh"]
