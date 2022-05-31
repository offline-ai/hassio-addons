FROM riceball/tts:en_lite-1.1.0
LABEL maintainer="Riceball LEE <snowyu.lee@gmail.com>"

ENV LANG C.UTF-8

USER tts

ENV CONFIG_PATH /data/options.json

COPY run.sh /home/tts/run.sh

USER root
ENTRYPOINT ["/home/tts/run.sh"]
