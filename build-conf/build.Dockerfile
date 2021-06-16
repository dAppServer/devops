FROM docker:20.10-dind

RUN set -eux; \
	apk add --no-cache \
	    bash \
	    git \
	    make

WORKDIR /home/build

COPY . .


RUN chmod +x build.sh

ENTRYPOINT ["./build.sh"]