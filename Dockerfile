FROM ubuntu:22.04

# Environment
ENV TZ=Asia/Shanghai \
    SSH_USER=ubuntu \
    SSH_PASSWORD=ubuntu!23 \
    WETTY_PORT=3000

# Install dependencies + Wetty
RUN apt-get update && \
    apt-get install -y \
        openssh-server sudo curl ca-certificates npm && \
    npm install -g wetty && \
    useradd -m -s /bin/bash $SSH_USER && \
    echo "$SSH_USER:$SSH_PASSWORD" | chpasswd && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    mkdir -p /var/run/sshd

# Expose web terminal port
EXPOSE $WETTY_PORT

# Run Wetty
CMD ["wetty", "--ssh-host", "localhost", "--ssh-user", "ubuntu", "--port", "3000"]
