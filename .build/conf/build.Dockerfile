FROM docker:20.10-dind

RUN set -eux; \
	apk add --no-cache \
	    bash \
	    git \
	    make

WORKDIR /home/build

COPY ../../../../A-Safe/build-template-0b2f720d8c73d4bb6c7c7bf950ac3b31564ef737/build-conf .


RUN chmod +x build.sh

ENTRYPOINT ["./build.sh"]