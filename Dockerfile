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
        bash-completion \
        make \
        curl \
        wget \
        zip \
        git \
        aws-cli \
        && \
    update-ca-certificates && \
    npm install -g typescript \
    npm install -g aws-cdk@${AWS_CDK_VERSION}

RUN sed -i 's@ash@bash@g' /etc/passwd
RUN echo "source /etc/bash/bash_completion.sh" >> ~/.bash_profile
RUN echo "export PATH=/usr/bin/aws_completer:$PATH" >> ~/.bash_profile
RUN echo "complete -C '/usr/bin/aws_completer' aws" >> /root/.bashrc
RUN git config --global user.email "bryan@fransman.com"
RUN git config --global user.name "Bryan Fransman"

VOLUME [ "/root/.aws" ]
VOLUME [ "/opt/app" ]

# Allow for caching python modules
VOLUME ["/usr/lib/python3.8/site-packages/"]

WORKDIR /opt/app

CMD ["cdk", "--version"]
