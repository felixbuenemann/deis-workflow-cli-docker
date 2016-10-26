FROM alpine:3.4

MAINTAINER felix.buenemann@gmail.com

ARG WORKFLOW_VERSION=v2.7.0
RUN apk add --no-cache bash curl git jq openssh-client \
 && curl -fsSLO http://deis.io/deis-cli/install-v2.sh \
 && bash install-v2.sh $WORKFLOW_VERSION \
 && mv deis /usr/bin/ \
 && rm install-v2.sh \
 && test "$WORKFLOW_VERSION" = stable \
      -o "$WORKFLOW_VERSION" = "`deis version`"

COPY deis /usr/local/bin/
COPY git /usr/local/bin/

CMD ["deis"]