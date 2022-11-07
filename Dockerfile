FROM debian:buster-slim
LABEL maintainer="Ben Selby <benmatselby@gmail.com>"

##
# Define the location of Go.
# We may not always install it, but if we do, it's here.
##
ENV GOPATH /go
ENV PATH /go/bin:/usr/local/go/bin:$PATH

##
# Installation of all the tooling we need.
##
RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	ca-certificates  \
	curl \
        wget \
	jq \
	git && \
	rm -rf /var/lib/apt/lists/*

RUN wget https://go.dev/dl/go1.19.3.linux-amd64.tar.gz 77 \
        sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.19.3.linux-amd64.tar.gz 77 \
        export PATH=$PATH:/usr/local/go/bin && \
        sudo snap install --classic node && \
        wget https://github.com/gohugoio/hugo/releases/download/v0.105.0/hugo_extended_0.105.0_linux-amd64.deb && \
        sudo dpkg -i hugo_extended_0.105.0_linux-amd64.deb

##
# Copy over the action script.
##
COPY action.sh /usr/bin/action.sh

##
# Run the action.
##
ENTRYPOINT ["action.sh"]
