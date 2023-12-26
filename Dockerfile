ARG ALPINE_VERSION=3.19
ARG AWS_CDK_VERSION=2.116.0
FROM alpine:${ALPINE_VERSION}

RUN apk -v --no-cache --update add \
        nodejs \
        npm \
        python3 \
        ca-certificates \
        groff \
        less \
        bash \
        make \
        curl \
        wget \
        zip \
        git \
        && \
    update-ca-certificates && \
    npm install -g typescript \
    npm install -g aws-cdk@${AWS_CDK_VERSION}

RUN git config --global user.email "bryan@fransman.com"
RUN git config --global user.name "Bryan Fransman"

VOLUME [ "/root/.aws" ]
VOLUME [ "/opt/app" ]

# Allow for caching python modules
VOLUME ["/usr/lib/python3.8/site-packages/"]

WORKDIR /opt/app

CMD ["cdk", "--version"]
