FROM docker.io/oiprnd/oiptools:alpine-stable
MAINTAINER Patrice Lachance

USER root

ADD . /app
WORKDIR /app
RUN apk update && \
    apk add --virtual .build-dependencies g++ && \
    npm install && \
    apk del .build-dependencies && \
    rm -rf /var/cache/apk/*

WORKDIR $WORKDIR

EXPOSE 3000

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["node", "/app/app.js", "-p", "3000"]

# Allow group access to project files
RUN chgrp -R 0 /app && \
    chmod -R g=u /app

# Allow entrypoint.sh to edit /etc/password
RUN chmod g=u /etc/passwd

# Change to openshift default user id
USER 1001

