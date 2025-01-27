FROM ubuntu:22.04

RUN apt-get update \
    && apt-get install --no-install-recommends -y ca-certificates \
        gnupg \
        curl \
        sudo \
        jq \
        gcc \
        g++ \
        git \
        make \
        python3-pip \
        cmake \
        zip \
    && pip install --no-cache-dir --upgrade cmake \
        && install -m 0755 -d /etc/apt/keyrings \
        && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
        && chmod a+r /etc/apt/keyrings/docker.gpg \
        && echo \
            "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
            $(. /etc/os-release && echo ""$VERSION_CODENAME"") stable" | \
            tee /etc/apt/sources.list.d/docker.list > /dev/null \
        && apt-get update \
        && apt-get install --no-install-recommends -y docker-ce \
            docker-ce-cli \
            containerd.io \
            docker-buildx-plugin \
            docker-compose-plugin \
        && apt-get clean \
        && apt-get upgrade -y \
        && rm -rf /var/lib/apt/lists* /tmp/*
