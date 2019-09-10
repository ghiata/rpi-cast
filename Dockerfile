FROM balenalib/raspberry-pi-alpine

RUN apk --no-cache add omxplayer openssh shadow

RUN mkdir /var/run/sshd \
    && echo 'root:myPassword' | chpasswd \
    && sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
RUN ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa

# We set the working directory for the next few commands
WORKDIR /usr/src/app

COPY . ./

CMD ["bash", "/usr/src/app/start.sh"]