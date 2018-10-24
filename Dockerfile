FROM docker.io/oiprnd/oiptools:alpine-stable
MAINTAINER Patrice Lachance

ADD . /app
WORKDIR /app
RUN npm install
#RUN apt-get update
#RUN apt-get install -y vim
#RUN useradd -d /home/term -m -s /bin/bash term
#RUN echo 'term:term' | chpasswd

EXPOSE 3000

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["node", "app.js", "-p", "3000"]

# Allow group access to project files
RUN chgrp -R 0 /app && \
    chmod -R g=u /app

# Allow entrypoint.sh to edit /etc/password
RUN chmod g=u /etc/passwd

# Change to openshift default user id
USER 1001

